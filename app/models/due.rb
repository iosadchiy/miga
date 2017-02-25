# == Schema Information
#
# Table name: dues
#
#  id         :integer          not null, primary key
#  kind       :integer          not null
#  purpose    :string           not null
#  unit       :integer          not null
#  price      :decimal(, )      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Due < ApplicationRecord
  enum kind: [:entrance, :membership, :target]
  enum unit: [:per_square_meter, :per_plot, :per_member]

  has_many :transactions, inverse_of: :payable, as: :payable do
    def by_member(member)
      joins(:payment).where(payments: {member: member})
    end
  end
  has_and_belongs_to_many :members
  attr_accessor :select_all_members

  validates :kind, :purpose, :unit, :price, presence: true
  validates_each :members do |record, attr, value|
    record.errors.add(attr, 'only active allowed') unless record.members.all?(&:active?)
  end

  before_destroy do
    throw :abort unless can_be_destroyed?
  end

  # Returns a service due which collects all non-standard transactions
  def self.service
    find_by(id: Setting.config[:service_due_id]) || create_service_due!
  end

  def self.create_service_due!
    create!(
      kind: :target,
      purpose: I18n.t('dues.service.purpose'),
      unit: :per_member,
      price: 0
    ).tap do |due|
      Setting.set!(:service_due_id, due.id)
    end
  end

  def altogether_for(member)
    send "calc_altogether_#{unit}", member
  end
  def calc_altogether_per_square_meter(member)
    price * member.space
  end
  def calc_altogether_per_plot(member)
    price * member.plots.count
  end
  def calc_altogether_per_member(member)
    price
  end

  def paid_so_far_by(member)
    transactions.by_member(member).pluck(:total).sum
  end

  def left_to_pay_by(member)
    altogether_for(member) - paid_so_far_by(member)
  end

  def can_be_destroyed?
    transactions.empty?
  end
end
