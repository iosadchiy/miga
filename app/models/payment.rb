# == Schema Information
#
# Table name: payments
#
#  id         :integer          not null, primary key
#  member_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_payments_on_member_id  (member_id)
#

class Payment < ApplicationRecord
  belongs_to :member
  has_many :transactions, inverse_of: :payment
  accepts_nested_attributes_for :transactions, reject_if: ->(hash) do
    hash[:total].empty?
  end
  default_scope { includes(:transactions) }

  def total
    transactions.map(&:total).sum
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

    (member.registers + member.dues).map { |payable|
      Transaction.new(
        (hash[payable.class][payable.id] rescue {}).merge(
          payment: self,
          payable: payable
        )
      )
    }.reject { |transaction|
      transaction.due? && transaction.fully_paid?
    }.reduce({}) { |res, t|
      res.tap do |r|
        r[t.payable.kind.to_sym] ||= []
        r[t.payable.kind.to_sym].push t
      end
    }
  end
end
