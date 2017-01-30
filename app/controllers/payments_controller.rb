class PaymentsController < ApplicationController
  def index
  end

  def new
    @payment = Payment.new(member: Member.owner_of(plot_number))
  end

  def plot_number
    params.require(:plot_number)
  end
end
