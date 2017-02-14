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
      errors.add :total, I18n.t('errors.messages.mismatch')
    end
  end

  # Builds an array of new transactions,
  # one for each register or due of the payer
  # and merges in corresponding attributes
  # Usage:
  #   @transactions = @payment
  #     .new_transactions(payment_params[:transactions_attributes])
  def new_transactions(attributes={}, &block)
    hash = attributes.to_h.values.reduce({}) { |res, v|
      type = v["payable_type"].constantize
      id = v["payable_id"].to_i
      res[type] ||= {}
      res[type][id] = v
      res
    }

    (member.registers + Due.entrance).map { |payable| 
      Transaction.new(
        (hash[payable.class][payable.id] rescue {}).merge(
          payment: self,
          payable: payable
        )
      )
    }.reduce({}) { |res, t|
      res.tap do |r|
        r[t.payable.kind.to_sym] ||= []
        r[t.payable.kind.to_sym].push t
      end
    }
  end
end
