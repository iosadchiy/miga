class PlotsController < ApplicationController
  def index
    self.page_title = t 'plots.index.title'
    @plots = Plot.all
  end
end
