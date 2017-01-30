class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale
  add_flash_types :danger, :warning, :info, :success

  def set_locale
    I18n.locale = :ru
  end
end
