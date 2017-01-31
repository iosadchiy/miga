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
    if @plot.valid?
      redirect_to :plots, success: t('plots.flash.created')
    else
      render 'new'
    end
  end

  def update
    @plot = Plot.find(params[:id])
    self.page_title = t 'plots.edit.title', number: @plot.number
    if @plot.update(plot_params)
      redirect_to :plots, success: t('plots.flash.updated')
    else
      render 'edit'
    end
  end

  def destroy
    plot = Plot.find(params[:id])
    if plot.destroy
      redirect_to :plots, success: t('plots.flash.destroyed')
    else
      redirect_to plot, danger: t('plots.flash.cannot_destroy')
    end
  end

  def plot_params
    params.require(:plot).permit(:member_id, :number, :space, :cadastre, :ukrgosact)
  end
end
