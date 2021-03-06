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

require 'test_helper'

class TransactionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
