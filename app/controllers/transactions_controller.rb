class TransactionsController < ApplicationController
  def index
    self.page_title = t('transactions.index.title')
    @transactions = Transaction.order(number: :desc)
      .includes(:payable, payment: :member)
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
    params.require(:transaction).permit(:number, :total)
  end
end
