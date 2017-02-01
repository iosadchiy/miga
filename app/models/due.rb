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

class Due < ApplicationRecord
end
