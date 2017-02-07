# == Schema Information
#
# Table name: transactions
#
#  id            :integer          not null, primary key
#  type          :string           not null
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
#  index_transactions_on_type         (type)
#

class Transaction < ApplicationRecord
  belongs_to :payment

  validates :total, presence: true, numericality: {greater_than: 0}
  validates :details, presence: true

  def start_display_edit_allowed?
    register.start_display.nil?
  end
end
