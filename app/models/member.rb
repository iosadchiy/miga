class Member < ApplicationRecord
  ACTIVE = 'Active'
  DELETED = 'Deleted'

  has_many :plots, -> { order :number }

  scope :active, -> { where(status: ACTIVE) }
  scope :deleted, -> { where(status: DELETED) }

  validates :fio, presence: true
  validates :status, presence: true, inclusion: {in: [ACTIVE, DELETED]}

  def self.owner_of(plot_number)
    Plot.find_by!(number: plot_number).member
  end
end
