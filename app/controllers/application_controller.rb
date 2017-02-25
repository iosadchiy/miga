require "application_responder"

class ApplicationController < ActionController::Base
  http_basic_authenticate_with name: "tester", password: ENV['HTTP_BASIC_AUTH_PASSWORD']

  self.responder = ApplicationResponder
  respond_to :html

  protect_from_forgery with: :exception
  before_action :set_locale, :process_params
  add_flash_types :danger, :warning, :info, :success

  attr_accessor :page_title
  helper_method :page_title
  attr_accessor :page_title_link
  helper_method :page_title_link

  helper_method :referer
  def referer(fallback = nil)
    request.referer || fallback || root_path
  end

  def set_locale
    I18n.locale = :ru
  end

  # Find all scalars which appear to be numbers
  # and replace "," with a "."
  def process_params(hash = nil)
    hash ||= params
    hash.each do |k,v|
      puts hash.class.inspect
      if v.is_a?(String) && v.match(/^\d+,\d+$/)
        hash[k] = v.sub(",", ".")
      elsif v.is_a?(ActionController::Parameters)
        process_params(hash[k])
      end
    end
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
