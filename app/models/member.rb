# == Schema Information
#
# Table name: members
#
#  id         :integer          not null, primary key
#  fio        :string           not null
#  address    :string
#  phone      :string
#  email      :string
#  status     :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_members_on_status  (status)
#

class Member < ApplicationRecord
  enum status: [:active, :deleted]

  has_many :plots, -> { order :number }
  has_many :registers, through: :plots

  validates :fio, presence: true
  validates :status, presence: true

  default_scope { order :fio }
  scope :active_plus_owner_of, ->(plot) {
    where("status = ? OR id = ?", statuses[:active], plot.member_id)
  }

  def self.owner_of(plot_number)
    Plot.find_by!(number: plot_number).member
  end

  def space
    plots.pluck(:space).sum
  end

  def membership_dues_debt
    1234
  end

  def other_dues_debt
    4321
  end

  def destroy
    update(status: :deleted)
  end
  alias_method :destroy!, :destroy
end
