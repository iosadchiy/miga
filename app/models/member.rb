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
#  notes      :text             default(""), not null
#
# Indexes
#
#  index_members_on_status  (status)
#

class Member < ApplicationRecord
  enum status: [:active, :deleted]

  has_many :plots, -> { order :number }
  has_many :registers, through: :plots
  has_many :payments, -> { order created_at: :desc }
  has_and_belongs_to_many :dues
  attr_accessor :select_all_dues

  validates :fio, presence: true
  validates :status, presence: true

  default_scope { order(:fio).includes(:plots) }
  scope :active_plus_owner_of, ->(plot) {
    where("status = ? OR id = ?", statuses[:active], plot.member_id)
      .includes(:plots)
  }

  def self.owner_of(plot_number)
    Plot.find_by!(number: plot_number).member
  end

  def space
    plots.pluck(:space).sum
  end

  def dues_debt
    dues.map{|d| d.left_to_pay_by(self)}.sum
  end

  def destroy
    update(status: :deleted)
  end
  alias_method :destroy!, :destroy
end
