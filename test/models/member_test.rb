# == Schema Information
#
# Table name: members
#
#  id         :integer          not null, primary key
#  fio        :string
#  address    :string
#  phone      :string
#  email      :string
#  status     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_members_on_status  (status)
#

require 'test_helper'

class MemberTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
