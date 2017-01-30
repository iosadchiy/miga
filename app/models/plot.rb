class Plot < ApplicationRecord
  belongs_to :member

  validates :number, presence: true, uniqueness: true
end
