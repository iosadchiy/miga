# == Schema Information
#
# Table name: transactions
#
#  id            :integer          not null, primary key
#  kind          :integer          not null
#  total         :decimal(, )      not null
#  price         :decimal(, )
#  start_display :integer
#  end_display   :integer
#  difference    :integer
#  details       :text             not null
#  payment_id    :integer
#  payable_id    :integer          not null
#  payable_type  :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  number        :integer
#  purpose       :string           default(""), not null
#
# Indexes
#
#  index_transactions_on_payable_type_and_payable_id  (payable_type,payable_id)
#  index_transactions_on_payment_id                   (payment_id)
#

class Transaction < ApplicationRecord
  include Transactions::UtilityTransaction
  include Transactions::DueTransaction
  enum kind: [:utility, :due]

  belongs_to :payment
  belongs_to :payable, polymorphic: true # either Due or Register

  accepts_nested_attributes_for :payment

  validates :kind, presence: true
  validates :total, presence: true, numericality: {greater_than: 0}
  validates :details, presence: true
  validates :number, presence: true
  validate do |txn|
    unless self.class.this_year.where(number: txn.number).where.not(id: txn.id).empty?
      txn.errors[:number] << "should be unique"
    end
  end

  serialize :details
  delegate :member, to: :payment

  before_validation do
    self.number ||= payment.next_transaction_number
    self.details = (self.details || {}).merge({
      payer: payment.member.attributes.merge(
        plots: payment.member.plots.map(&:attributes)
      )
    })
  end

  scope :today, -> { where("transactions.created_at >= ?", Time.zone.today) }
  scope :this_year, -> { where("transactions.created_at >= ?", Time.zone.now.beginning_of_year) }

  def self.next_number
    max_number + 1
  end

  def self.max_number
    txns = Transaction.this_year.order(number: :desc)
    txns.empty? ? 0 : txns.first.number
  end

  def self.number_in_series?
    all.empty? ||
      order(:number).last.number -
        order(:number).first.number + 1 == count
  end

  def self.missing_numbers
    (order(:number).first.number..order(:number).last.number).to_a -
      pluck(:number)
  end

  def self.paid_today
    today.pluck(:total).sum
  end

  def initialize(attributes)
    super
    self.kind = {Register => :utility, Due => :due}[payable.class] or
      raise "Unsupported #payable class"
    self.start_display ||= register.start_display if utility?
  end

  def start_display_edit_allowed?
    register.start_display.nil?
  end

  def due_kind
    due.kind
  end
end
