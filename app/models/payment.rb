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

  # Builds a new utility transaction
  # one for each register of the payer
  # and merges in corresponding attributes
  # Usage:
  #   @utility_transactions = @payment
  #     .new_utility_transactions(payment_params[:transactions_attributes])
  def new_utility_transactions(attributes = {})
    new_transactions(attributes, member.registers) do |transaction, register|
      transaction.start_display = register.start_display
    end
  end

  def new_entrance_transactions(attributes = {})
    new_transactions(attributes, Due.entrance)
  end

  def new_transactions(attributes, source_collection, &block)
    source_class = source_collection.first.class
    kind = {Register => :utility, Due => :due}[source_class] or
      raise "unsupported source_collection"

    hash = attributes.to_h.values.reduce({}) { |res, v|
      type = v["payable_type"].constantize
      id = v["payable_id"].to_i
      res[type] ||= {}
      res[type][id] = v
      res
    }
    source_collection.map { |source|
      Transaction.new(
        payment: self,
        kind: kind
      ).tap do |t|
        t.payable = source
        t.attributes = hash[source.class][source.id] if hash[source.class][source.id]
        yield(t, source) if block
      end
    }
  end
end
