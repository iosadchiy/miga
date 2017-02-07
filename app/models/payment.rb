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
  has_many :utility_transactions
  accepts_nested_attributes_for :utility_transactions, reject_if: ->(hash) do
    hash[:total].empty?
  end

  validates :total, presence: true, numericality: true

  # Builds new UtilityTransaction instances
  # one for each register of the payer
  # and merges in corresponding attributes
  # Usage:
  #   @utility_transactions = @payment
  #     .new_utility_transactions(payment_params[:utility_transactions_attributes])

  def new_utility_transactions(attributes = {})
    hash = attributes.to_h.values.reduce({}) { |res, v|
      res.merge v["register_id"].to_i => v
    }
    member.registers.map do |register|
      UtilityTransaction.new(
        register: register,
        payment: self,
        start_display: register.start_display
      ).tap do |t|
        t.attributes = hash[register.id] if hash[register.id]
      end
    end
  end
end
