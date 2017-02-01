# == Schema Information
#
# Table name: dues
#
#  id         :integer          not null, primary key
#  purpose    :string
#  unit       :string
#  price      :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class DueTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
