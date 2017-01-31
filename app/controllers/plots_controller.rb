class PlotsController < ApplicationController
  def index
    self.page_title = t 'plots.index.title'
    @plots = Plot.order(:number)
  end

  def edit
    @plot = Plot.find(params[:id])
    self.page_title = t 'plots.edit.title', number: @plot.number
  end

  def new
    @plot = Plot.new
    self.page_title = t 'plots.new.title'
  end

  def create
    @plot = Plot.create(plot_params)
    self.page_title = t 'plots.new.title'
    respond_with @plot
  end

  def update
    @plot = Plot.find(params[:id])
    self.page_title = t 'plots.edit.title', number: @plot.number
    @plot.update(plot_params)
    respond_with @plot
  end

  def destroy
    plot = Plot.find(params[:id])
    plot.destroy
    respond_with plot
  end

  def plot_params
    params.require(:plot).permit(:member_id, :number, :space, :cadastre, :ukrgosact)
  end
end
