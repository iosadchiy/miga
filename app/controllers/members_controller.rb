class MembersController < ApplicationController
  def index
    self.page_title = t('members.index.title')
    @members = Member.active.map{|m| MemberPresenter.new(m)}
    @deleted_members = Member.deleted.map{|m| MemberPresenter.new(m)}
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
