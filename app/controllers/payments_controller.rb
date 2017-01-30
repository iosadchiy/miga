class PaymentsController < ApplicationController
  def index
  end

  def new
    @payment = Payment.new(member: Member.owner_of(plot_number))
  rescue ActiveRecord::RecordNotFound => e
    raise e unless e.model == "Plot"
    redirect_to :payments, danger: t('payments.no_such_plot')
  end

  def plot_number
    params.require(:plot_number)
  end
end
