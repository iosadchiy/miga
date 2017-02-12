# == Schema Information
#
# Table name: payments
#
#  id         :integer          not null, primary key
#  member_id  :integer
#  status     :integer          not null
#  total      :decimal(, )      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_payments_on_member_id  (member_id)
#

class Payment < ApplicationRecord
  enum status: [:pending, :finished]
  belongs_to :member
  has_many :transactions, inverse_of: :payment
  accepts_nested_attributes_for :transactions, reject_if: ->(hash) do
    hash[:total].empty?
  end

  before_validation do
    self.status = :pending
  end

  validates :total, presence: true, numericality: {greater_than: 0}
  validates :status, presence: true

  validate do
    sum = transactions.reduce(0) { |sum, t|
      sum + t.total
    }
    unless total == sum
      errors.add :total, "mismatch"
    end
  end

  # Builds a new utility transaction
  # one for each register of the payer
  # and merges in corresponding attributes
  # Usage:
  #   @utility_transactions = @payment
  #     .new_utility_transactions(payment_params[:transactions_attributes])

  def new_utility_transactions(attributes = {})
    hash = attributes.to_h.values.reduce({}) { |res, v|
      res.merge v["register_id"].to_i => v
    }
    member.registers.map do |register|
      Transaction.new(
        kind: :utility,
        register: register,
        payment: self,
        start_display: register.start_display
      ).tap do |t|
        t.attributes = hash[register.id] if hash[register.id]
      end
    end
  end
end
