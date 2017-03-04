# == Schema Information
#
# Table name: members
#
#  id         :integer          not null, primary key
#  fio        :string           not null
#  address    :string
#  phone      :string
#  email      :string
#  status     :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  notes      :text             default(""), not null
#
# Indexes
#
#  index_members_on_status  (status)
#

require 'test_helper'

class MembersControllerTest < ActionDispatch::IntegrationTest
end
