class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale
  add_flash_types :danger, :warning, :info, :success

  attr_accessor :page_title
  helper_method :page_title

  def set_locale
    I18n.locale = :ru
  end
end
