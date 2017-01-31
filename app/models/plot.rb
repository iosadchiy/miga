class Plot < ApplicationRecord
  belongs_to :member, optional: true

  validates :number, presence: true, uniqueness: true
  validates :space, numericality: {allow_nil: true,
      greater_than_or_equal_to: 10, less_than_or_equal_to: 10000}
end
