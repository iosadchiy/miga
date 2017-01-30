class Member < ApplicationRecord
  ACTIVE = 'Active'
  DELETED = 'Deleted'

  scope :active, -> { where(status: ACTIVE) }
  scope :deleted, -> { where(status: DELETED) }

  def self.owner_of(plot_number)
    Plot.find_by!(number: plot_number).member
  end
end
