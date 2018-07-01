module Transactions::UtilityTransaction
  extend ActiveSupport::Concern

  included do
    before_validation do
      if utility?
        self.start_display ||= register.start_display || self.start_display || 0
        self.difference ||= self.start_display && self.end_display && (self.end_display - self.start_display)
        self.price = Setting.config["price_#{register.kind}"]
        self.details = (self.details || {}).merge({
          register: register.attributes.merge(
            plot: register.plot.attributes
          )
        })
      end
    end

    validate do
      if utility?
        if end_display && start_display and end_display - start_display != difference
          errors.add :difference, "invalid display"
        end
        if difference && total and difference * price != total
          errors.add :total, "mismatch"
        end
      end
    end
    validates :start_display, :end_display, :difference,
      presence: true, numericality: {only_integer: true, allow_nil: true}, if: -> { utility? }
    validates :price, presence:true, numericality: {greater_than: 0}, if: -> { utility? }
  end

  def register
    payable
  end
end
