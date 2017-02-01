class DuesController < ApplicationController
  def index
    self.page_title = t 'dues.index.title'
    @entrance_dues = Due.entrance
    @target_dues = Due.target
    @membership_dues = Due.membership
  end
end
