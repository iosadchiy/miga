class PlotsController < ApplicationController
  def index
    self.page_title = t 'plots.index.title'
    @plots = Plot.all
  end

  def edit
    @plot = Plot.find(params[:id])
    self.page_title = t 'plots.edit.title', number: @plot.number
  end
end
