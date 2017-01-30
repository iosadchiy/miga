class PaymentsController < ApplicationController
  respond_to :html

  def index
    respond_with []
  end

  def new
    respond_with Payment.new(member: Member.owner_of(plot_number))
  end

  def plot_number
    params.require(:plot_number)
  end
end
