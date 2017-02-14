class PaymentsController < ApplicationController

  class PlotNotValidError < RuntimeError; end
  before_action :load_payment, only: [:show, :confirm, :print]

  def index
    self.page_title = t('payments.title')
  end

  def new
    self.page_title = t('payments.new.title')
    @payment = Payment.new(member: member)
    @transactions = @payment.new_transactions
    @member = member.decorate
  end

  def create
    self.page_title = t('payments.new.title')
    @payment = Payment.create(payment_params)
    @transactions = @payment.new_transactions(transactions_params)
    @member = member.decorate
    respond_with @payment, location: -> { @payment }
  end

  def show
    self.page_title = t('payments.show.title')
  end

  def print
    respond_to do |format|
      format.html do
        render layout: 'pdf'
      end
      format.pdf do
        render pdf: 'print',
          orientation: 'Landscape',
          page_size: 'A5',
          layout: 'pdf'
      end
    end
  end

  def confirm
    @payment.update_attribute :status, :finished
    respond_with @payment, notice: t('.notice')
  end

  def load_payment
    @payment = Payment.find(params[:id])
  end

  def member
    @_member_cache ||= if params[:payment]
        Member.find(params[:payment][:member_id])
      else
        plot = Plot.find_by(number: params[:plot_number]) or
          raise PlotNotValidError.new t('payments.no_such_plot')
        plot.member or
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
          :kind, :payable_id, :payable_type, :total, :start_display, :end_display, :difference]
      )
  end

  def transactions_params
    payment_params[:transactions_attributes]
  end

  def utility_transactions_params
    payment_params[:transactions_attributes].select{|i,attrs|
      attrs[:kind] == "utility"
    }
  end

  def entrance_transactions_params
    payment_params[:transactions_attributes].select{|i,attrs|
      attrs[:kind] == "due" && Due.find(attrs[:payable_id]).entrance?
    }
  end
end
