class PaymentsController < ApplicationController
  respond_to :html

  def index
    respond_with []
  end
end
