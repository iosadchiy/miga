# == Schema Information
#
# Table name: counters
#
#  id         :integer          not null, primary key
#  type       :string
#  number     :string
#  seal       :string
#  display    :integer
#  member_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_counters_on_member_id  (member_id)
#

class Counter < ApplicationRecord
  belongs_to :member
end
