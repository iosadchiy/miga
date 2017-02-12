class PaymentsController < ApplicationController

  class PlotNotValidError < RuntimeError; end
  before_action :load_member, only: [:new, :create]

  def index
    self.page_title = t('payments.title')
  end

  def new
    self.page_title = t('payments.new.title')
    @payment = Payment.new(member: @member)
    @utility_transactions = @payment.new_utility_transactions
  end

  def create
    self.page_title = t('payments.new.title')
    @payment = Payment.create(payment_params)
    @utility_transactions = @payment
      .new_utility_transactions(utility_transactions_params)
    respond_with @payment, location: -> { @payment }
  end

  def show
    self.page_title = t('payments.show.title')
    @payment = Payment.find(params[:id])
  end

  def load_member
    if params[:payment]
      @member = Member.find(params[:payment][:member_id]).decorate
    else
      plot = Plot.find_by(number: params[:plot_number]) or
        raise PlotNotValidError.new t('payments.no_such_plot')
      @member = plot.member.decorate or
        raise PlotNotValidError.new t('payments.no_member')
    end
  rescue PlotNotValidError => e
    redirect_back fallback_location: :payments, danger: e.message
  end

  def payment_params
    params
      .require(:payment)
      .permit(
        :member_id,
        :total,
        transactions_attributes: [
          :kind, :register_id, :total, :start_display, :end_display, :difference]
      )
  end

  def utility_transactions_params
    payment_params[:transactions_attributes].select{|i,attrs|
      attrs[:kind] == "utility"
    }
  end
end
