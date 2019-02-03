# == Schema Information
#
# Table name: registers
#
#  id              :integer          not null, primary key
#  plot_id         :integer
#  kind            :integer          not null
#  name            :string
#  number          :string
#  initial_display :integer
#  seal            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  active          :boolean          default(TRUE), not null
#
# Indexes
#
#  index_registers_on_plot_id  (plot_id)
#

class Register < ApplicationRecord
  enum kind: [:electricity, :water, :electricity_day, :electricity_night]
  belongs_to :plot
  has_many :transactions, inverse_of: :payable, as: :payable

  validates :kind, presence: true

  def human_name
    [
      self.class.human_attribute_name("kind.#{kind}"),
      ("\"#{name}\"" if name.present?)
    ].compact.join(" ")
  end

  def start_display
    transactions.order('end_display DESC').pluck(:end_display).first || initial_display
  end
end
