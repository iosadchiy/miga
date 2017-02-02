# == Schema Information
#
# Table name: dues
#
#  id         :integer          not null, primary key
#  kind       :integer          not null
#  purpose    :string           not null
#  unit       :integer          not null
#  price      :decimal(, )      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class DueTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
