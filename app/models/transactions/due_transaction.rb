module Transactions::DueTransaction
  extend ActiveSupport::Concern

  included do
    belongs_to :due, optional: true

    before_validation do
      if due?
        self.details = (self.details || {}).merge({
          due: due.attributes
        })
      end
    end
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
end
