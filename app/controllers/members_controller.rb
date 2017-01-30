class MembersController < ApplicationController
  def index
    self.page_title = t('members.title')
    @members = Member.all
  end

  def create
  end

  def new
  end

  def edit
  end

  def show
  end

  def delete
  end
end
