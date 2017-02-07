# == Schema Information
#
# Table name: transactions
#
#  id            :integer          not null, primary key
#  type          :string           not null
#  total         :decimal(, )      not null
#  price         :decimal(, )
#  start_display :integer
#  end_display   :integer
#  difference    :integer
#  details       :text             not null
#  payment_id    :integer
#  register_id   :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_transactions_on_payment_id   (payment_id)
#  index_transactions_on_register_id  (register_id)
#  index_transactions_on_type         (type)
#

class UtilityTransaction < Transaction
  belongs_to :register
  validates :start_display, :end_display, :difference,
    presence: true, numericality: {only_integer: true, allow_nil: true}
  validates :price, presence:true, numericality: {greater_than: 0}

  before_validation do
    self.start_display = register.start_display || self.start_display
    self.price = Setting.config["price_#{register.kind}"]
    self.details = (self.details || {}).merge({
      register: register.attributes.merge(
        plot: register.plot.attributes
      )
    })
  end

  validate do
    if end_display - start_display != difference
      errors.add :difference, "invalid display"
    end
    if difference * price != total
      errors.add :total, "mismatch"
    end
  end
end
