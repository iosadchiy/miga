# == Schema Information
#
# Table name: payments
#
#  id         :integer          not null, primary key
#  member_id  :integer
#  total      :decimal(, )      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_payments_on_member_id  (member_id)
#

class Payment < ApplicationRecord
  belongs_to :member
  has_many :transactions

  def new_utility_transactions
    member.registers.map do |register|
      Transaction.new(
        kind: :utility,
        register: register,
        payment: self,
        start_display: register.start_display
      )
    end
  end
end
