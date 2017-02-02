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

class Due < ApplicationRecord
  enum kind: [:entrance, :membership, :target]
  enum unit: [:per_square_meter, :per_plot, :per_member]
  validates :kind, :purpose, :unit, :price, presence: true
end
