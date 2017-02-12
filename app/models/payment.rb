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
    group_by = {utility: "register_id", due: "due_id"}[kind]
    reference_key = source_class.to_s.downcase + "_id"

    hash = attributes.to_h.values.reduce({}) { |res, v|
      res.merge v[group_by].to_i => v
    }
    source_collection.map { |source|
      Transaction.new(
        payment: self,
        kind: kind
      ).tap do |t|
        t.write_attribute(reference_key, source.id)
        t.attributes = hash[source.id] if hash[source.id]
        yield(t, source) if block
      end
    }
  end
end
