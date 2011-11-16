class ApplicationController < ActionController::Base
  include Authentication
  protect_from_forgery
  before_filter :set_locale

private
  def set_locale
    I18n.locale = LocaleDispatcher.locale(current_codabra)
  end
end
