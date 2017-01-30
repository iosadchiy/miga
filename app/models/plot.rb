class Plot < ApplicationRecord
  belongs_to :member

  validates :number, presence: true, uniqueness: true
  validates :space, presence: true, numericality: true, inclusion: {in: 10..10000}
end
