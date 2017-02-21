class SettingsController < ApplicationController
  def edit
    self.page_title = t 'settings.title'
    @setting = Setting.first
  end

  def update
    self.page_title = t 'settings.title'
    @setting = Setting.first
    if @setting.update(setting_params)
      redirect_to [:edit, :setting], success: t('settings.edited') and return
    else
      flash[:danger] = t('settings.cannot_edit')
      render 'edit'
    end
  end

  def setting_params
    params.require(:setting).permit(:price_electricity, :price_water, :cashier)
  end
end
