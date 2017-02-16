class DuesController < ApplicationController
  def index
    self.page_title = t 'dues.index.title'
    @entrance_dues = Due.entrance
    @target_dues = Due.target
    @membership_dues = Due.membership
  end

  def new
    self.page_title = t 'dues.new.title'
    @due = Due.new(kind: params[:kind])
  end

  def create
    self.page_title = t 'dues.new.title'
    @due = Due.create(due_params)
    respond_with @due
  end

  def edit
    self.page_title = t 'dues.edit.title'
    @due = Due.find(params[:id])
  end

  def update
    self.page_title = t 'dues.edit.title'
    @due = Due.find(params[:id])
    @due.update(due_params)
    respond_with @due
  end

  def due_params
    params.require(:due).permit(:kind, :purpose, :unit, :price)
  end
end
