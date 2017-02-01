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

class Plot < ApplicationRecord
  belongs_to :member, optional: true

  validates :number, presence: true, uniqueness: true
  validates :space, numericality: {allow_nil: true,
      greater_than_or_equal_to: 10, less_than_or_equal_to: 10000}
end
