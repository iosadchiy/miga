class TransactionsController < ApplicationController
  def index
    self.page_title = t('transactions.index.title')
    @transactions = Transaction.order(number: :desc)
      .includes(:payable, payment: :member)
  end

  def new
    self.page_title = t('transactions.new.title')
    @transaction = Transaction.new(
      number: Transaction.next_number,
      payable: Due.custom,
      payment: Payment.new(member_id: params[:member_id])
    )
  end

  def create
    self.page_title = t('transactions.new.title')
    @transaction = Transaction.create!(transaction_params.merge(
      payable: Due.custom
    ))
    respond_with @transaction
  end

  def edit
    self.page_title = t('transactions.edit.title')
    @transaction = Transaction.find(params[:id])
  end

  def update
    self.page_title = t('transactions.edit.title')
    @transaction = Transaction.find(params[:id])
    @transaction.update(transaction_params)
    respond_with @transaction
  end

  def destroy
    @transaction = Transaction.find(params[:id])
    @transaction.destroy
    respond_with @transaction
  end

  def transaction_params
    params.require(:transaction).permit(
      :number,
      :total,
      :purpose,
      payment_attributes: [:member_id]
    )
  end
end
