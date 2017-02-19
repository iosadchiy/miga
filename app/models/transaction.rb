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

  validates :kind, presence: true
  validates :total, presence: true, numericality: {greater_than: 0}
  validates :details, presence: true

  serialize :details
  delegate :member, to: :payment

  before_validation do
    self.details = (self.details || {}).merge({
      payer: payment.member.attributes.merge(
        plots: payment.member.plots.map(&:attributes)
      )
    })
  end

  def self.id_in_series?
    all.empty? ||
      order(:id).last.id - order(:id).first.id + 1 == count
  end

  def initialize(attributes)
    super
    self.kind = {Register => :utility, Due => :due}[payable.class] or
      raise "Unsupported #payable class"
    self.start_display = register.start_display if utility?
  end

  def start_display_edit_allowed?
    register.start_display.nil?
  end

  def number
    # TODO: should go in sequence, with only confirmed counted
    id
  end

  def due_kind
    due.kind
  end
end
