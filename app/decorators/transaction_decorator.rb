class TransactionDecorator < Draper::Decorator
  delegate_all

  def created_at
    object.created_at.localtime
  end
  def created_at_date
    created_at.to_s(:date)
  end
  def created_at_day
    created_at.strftime("%d")
  end
  def created_at_month
    created_at.strftime("%m")
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
    object.payment.member.fio
  end

  def ground
    "Оплата за TODO"
  end
end
