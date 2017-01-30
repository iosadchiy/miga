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

  def membership_dues_debt
    1234
  end

  def other_dues_debt
    4321
  end
end
