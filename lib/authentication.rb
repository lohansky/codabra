# This module is included in your application controller which makes
# several methods available to all controllers and views. Here's a
# common example you might add to your application layout file.
#
#   <% if logged_in? %>
#     Welcome <%=h current_user.username %>! Not you?
#     <%= link_to "Log out", logout_path %>
#   <% else %>
#     <%= link_to "Sign up", signup_path %> or
#     <%= link_to "log in", login_path %>.
#   <% end %>
#
# You can also restrict unregistered users from accessing a controller using
# a before filter. For example.
#
#   before_filter :user_required, :except => [:index, :show]
module Authentication
  def self.included(controller)
    controller.send :helper_method, :current_codabra, :logged_in?, :redirect_to_target_or_default, :store_location, :customer?,
                    :current_session, :session_admin?, :session_support?
  end

  def current_session
    return @current_session if defined?(@current_session)
    @current_session = Session.find
  end

  def current_codabra
    return @current_codabra if defined?(@current_codabra)
    @current_codabra = current_session && current_session.record
  end

  def logged_in?
    current_codabra
  end

  def login_required
    logged_in? || access_unauthorized
  end

  def no_login_required
    if logged_in?
      store_location
      flash[:alert] = I18n.t(:'errors.must_be_logged_out')
      redirect_to root_path
      return false
    end
  end

  def redirect_to_target_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end

  def store_location
    session[:return_to] = request.url
  end

private

  def access_unauthorized
    respond_to do |format|
      format.json do
        render json: [ I18n.t(:'errors.unauthorized')], status: :unauthorized
      end
      format.html do
        flash[:alert] = I18n.t(:'errors.must_login')
        store_location
        redirect_to signin_path
      end
      format.js do
        render json: I18n.t(:'errors.unauthorized'), status: :unauthorized
      end
    end
    false
  end

end
