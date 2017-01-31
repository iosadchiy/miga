class PaymentsController < ApplicationController
  def index
    self.page_title = t('payments.title')
  end

  def new
    self.page_title = t('payments.new.title')
    plot = Plot.find_by(number: plot_number) or
      redirect_back fallback_location: :payments, danger: t('payments.no_such_plot')
    member = plot.member or
      redirect_back fallback_location: :payments, warning: t('payments.no_member')
    @member = MemberPresenter.new(member)
    @payment = PaymentPresenter.new(Payment.new(member: member))
  end

  def plot_number
    params.require(:plot_number)
  end
end
