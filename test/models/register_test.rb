# == Schema Information
#
# Table name: registers
#
#  id         :integer          not null, primary key
#  plot_id    :integer
#  kind       :integer          not null
#  name       :string
#  number     :string
#  display    :integer
#  seal       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_registers_on_plot_id  (plot_id)
#

require 'test_helper'

class RegisterTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
