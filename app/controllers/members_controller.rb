class MembersController < ApplicationController
  before_action :load_resource

  def index
    self.page_title = t('members.index.title')
    @members = Member.active.includes(:plots).decorate
    @deleted_members = Member.deleted.decorate
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
    self.page_title_link = [t('shared.to_payments'),
      [:new, :payment, plot_number: @member.plots.first.number]] unless
        @member.plots.empty?
  end

  def update
    self.page_title = t('members.edit.title', fio: @member.fio)
    @member.update(member_params)
    respond_with @member, location: -> { params[:back] }
  end

  def show
  end

  def destroy
    @member.destroy
    respond_with @member
  end

  def member_params
    params.require(:member).permit(:fio, :address, :phone, :email, due_ids: [])
  end
end
