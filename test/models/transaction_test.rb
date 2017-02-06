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

require 'test_helper'

class TransactionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end