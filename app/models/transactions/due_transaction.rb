module Transactions::DueTransaction
  extend ActiveSupport::Concern

  included do
    before_validation do
      if due?
        self.details = (self.details || {}).merge({
          due: due.attributes
        })
      end
    end

    validate do
      if due?
        if paid_so_far + total - altogether >= 0.01
          # errors.add :total, "overpaying"
        end
      end
    end
  end

  def due
    payable
  end

  def altogether
    due.altogether_for(member)
  end

  def paid_so_far
    due.paid_so_far_by(member)
  end

  def left_to_pay
    due.left_to_pay_by(member)
  end

  def fully_paid?
    left_to_pay <= 0
  end
end
