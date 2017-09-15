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
  enum kind: [:entrance, :membership, :target, :custom]
  enum unit: [:per_square_meter, :per_plot, :per_member]

  has_many :transactions, inverse_of: :payable, as: :payable do
    def by_member(member)
      joins(:payment).where(payments: {member: member})
    end
  end
  has_and_belongs_to_many :members
  attr_accessor :select_all_members

  validates :kind, :purpose, :unit, :price, presence: true

  before_destroy do
    throw :abort unless can_be_destroyed?
  end

  # Returns a custom due which collects all non-standard transactions
  def self.custom
    find_by(id: Setting.config[:custom_due_id]) || create_custom_due!
  end

  def custom?
    id == Setting.config[:custom_due_id]
  end

  def self.create_custom_due!
    create!(
      kind: :custom,
      purpose: I18n.t('dues.custom.purpose'),
      unit: :per_member,
      price: 0
    ).tap do |due|
      Setting.set!(:custom_due_id, due.id)
    end
  end

  def altogether_for(member)
    return 0 unless member.dues.include?(self)
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
