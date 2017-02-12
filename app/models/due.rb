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

  has_many :transactions, inverse_of: :due do
    def by_member(member)
      joins(:payment).where(payments: {member: member})
    end
  end

  validates :kind, :purpose, :unit, :price, presence: true

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
end
