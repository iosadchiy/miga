# == Schema Information
#
# Table name: plots
#
#  id         :integer          not null, primary key
#  number     :string
#  space      :integer
#  cadastre   :string
#  ukrgosact  :string
#  member_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_plots_on_member_id  (member_id)
#  index_plots_on_number     (number)
#

require 'test_helper'

class PlotTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
