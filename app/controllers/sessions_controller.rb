class SessionsController < ApplicationController
  before_filter :no_login_required, only: [:new, :create]
  before_filter :login_required, only: :destroy

  # GET /session/new
  def new
    flash[:alert] = ''
    @session = Session.new
  end

  # POST /session
  def create
    @session = Session.new(params[:session])
    if @session.save
      if @session.codabra.active?
        redirect_to session[:return_to] || profile_path(@session.codabra.name)
      else
        current_session.destroy
      end
    else
      flash[:alert] = t(:'errors.wrong_login_or_password')
      redirect_to signin_path
    end
  end

  # DELETE /session
  def destroy
    current_session.destroy
    redirect_to root_path
  end
end
