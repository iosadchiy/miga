class PaymentsController < ApplicationController

  class PlotNotValidError < RuntimeError; end
  before_action :load_member, only: [:new, :create]

  def index
    self.page_title = t('payments.title')
  end

  def new
    self.page_title = t('payments.new.title')
    @payment = Payment.new(member: @member)
  end

  def create
    self.page_title = t('payments.new.title')
  end

  def load_member
    if params[:payment]
      @member = Member.find(params[:payment][:member_id])
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
        transaction
      )
  end
end
