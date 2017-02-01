require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html

  protect_from_forgery with: :exception
  before_action :set_locale
  add_flash_types :danger, :warning, :info, :success

  attr_accessor :page_title
  helper_method :page_title

  helper_method :referer
  def referer(fallback = nil)
    request.referer || fallback || root_path
  end

  def set_locale
    I18n.locale = :ru
  end

  # Guess model class from controller name
  # and find it's instance by id from params
  def load_resource
    if action_name.in? %w(edit update destroy)
      resource_name = controller_name.singularize
      model_class = resource_name.capitalize.constantize
      resource = model_class.find(params[:id])
      instance_variable_set "@#{resource_name}", resource
    end
  end
end
