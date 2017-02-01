class DuesController < ApplicationController
  def index
    self.page_title = t 'dues.index.title'
    # @entrance_dues = Due.entrance
  end
end
