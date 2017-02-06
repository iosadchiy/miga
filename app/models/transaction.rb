# == Schema Information
#
# Table name: transactions
#
#  id            :integer          not null, primary key
#  kind          :integer          not null
#  total         :decimal(, )      not null
#  start_display :integer
#  end_display   :integer
#  difference    :integer
#  details       :text             not null
#  payment_id    :integer
#  register_id   :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_transactions_on_payment_id   (payment_id)
#  index_transactions_on_register_id  (register_id)
#

class Transaction < ApplicationRecord
  enum kind: [:utility, :due]
  belongs_to :payment
  belongs_to :register, optional: true

  validates :total, presence: true, numericality: true
  validates :start_display, :end_display, :difference, numericality: {only_integer: true, allow_nil: true}
  validates :details, presence: true

  def start_display_edit_allowed?
    register.start_display.nil?
  end
end
