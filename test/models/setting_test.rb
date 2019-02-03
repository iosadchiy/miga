# == Schema Information
#
# Table name: settings
#
#  id                      :integer          not null, primary key
#  price_electricity       :decimal(, )      not null
#  price_water             :decimal(, )      not null
#  cashier                 :string
#  custom_due_id           :integer
#  price_electricity_day   :decimal(, )      default(0.0), not null
#  price_electricity_night :decimal(, )      default(0.0), not null
#

require 'test_helper'

class SettingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
