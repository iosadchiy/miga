# == Schema Information
#
# Table name: transactions
#
#  id            :integer          not null, primary key
#  total         :decimal(, )
#  start_display :integer
#  end_display   :integer
#  details       :text
#  member_id     :integer
#  payment_id    :integer
#  register_id   :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_transactions_on_member_id    (member_id)
#  index_transactions_on_payment_id   (payment_id)
#  index_transactions_on_register_id  (register_id)
#

class Transaction < ApplicationRecord
  belongs_to :member
  belongs_to :payment
  belongs_to :register, optional: true

  validates :total, presence: true, numericality: true
  validates :start_display, :end_display, numericality: {only_integer: true, allow_nil: true}
  validates :details, presence: true
end
