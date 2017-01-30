class Member < ApplicationRecord
  ACTIVE = 'Active'
  DELETED = 'Deleted'

  scope :active, -> { where(status: ACTIVE) }
  scope :deleted, -> { where(status: DELETED) }
end
