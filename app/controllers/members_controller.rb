class MembersController < ApplicationController
  before_action :load_resource

  def index
    self.page_title = t('members.index.title')
    @members = Member.active.map{|m| MemberPresenter.new(m)}
    @deleted_members = Member.deleted.map{|m| MemberPresenter.new(m)}
  end

  def new
    self.page_title = t('members.new.title')
    @member = Member.new
  end

  def create
    self.page_title = t('members.new.title')
    @member = Member.create(member_params.merge(status: :active))
    respond_with @member
  end

  def edit
    self.page_title = t('members.edit.title', fio: @member.fio)
  end

  def update
    self.page_title = t('members.edit.title', fio: @member.fio)
    @member.update(member_params)
    respond_with @member
  end

  def show
  end

  def destroy
    @member.destroy
    respond_with @member
  end

  def member_params
    params.require(:member).permit(:fio, :address, :phone, :email)
  end
end
