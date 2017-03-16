class TransactionDecorator < Draper::Decorator
  delegate_all

  def created_at
    object.created_at.localtime
  end
  def created_at_date
    I18n.l created_at, format: "%d.%m.%y"
  end
  def created_at_day
    created_at.strftime("%d")
  end
  def created_at_month
    I18n.l created_at, format: "%B"
  end
  def created_at_year
    created_at.strftime("%Y")
  end

  def total
    h.number_to_currency(object.total, unit: '')
  end

  def total_rub
    object.total.floor
  end

  def total_kop
    kop = object.total.modulo(1)*100
    "%02d" % kop
  end

  def total_rub_words
    total_rub.to_words
  end

  def fio
    object.payment.member.decorate.to_s_pko
  end

  def ground
    self.send "ground_#{kind}"
  end

  def ground_utility
    I18n.t "transactions.ground.#{register.kind}",
      start_display: start_display,
      end_display: end_display,
      difference: difference,
      price: h.number_to_currency(Setting.config["price_#{register.kind}"])
  end

  def ground_due
    purpose = due.custom? ? self.purpose : due.purpose
    I18n.t "transactions.ground.#{due.kind}",
      purpose: purpose
  end

  def cashier
    Setting.config[:cashier]
  end
end
