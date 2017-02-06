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
    plot = Plot.find_by(number: plot_number) or
      raise PlotNotValidError.new t('payments.no_such_plot')
    @member = plot.member.decorate or
      raise PlotNotValidError.new t('payments.no_member')
  rescue PlotNotValidError => e
    redirect_back fallback_location: :payments, danger: e.message
  end

  def plot_number
    params.require(:plot_number)
  end
end
