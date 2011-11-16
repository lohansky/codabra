class PasswordsController < ApplicationController
  before_filter :load_codabra_using_password_salt, only: [:edit, :update]
  before_filter :no_login_required

  # GET /passwords/new
  def new
  end

  # POST /passwords/new
  def create
    @codabra = Codabra.find_by_email(params[:email])
    if @codabra
      @codabra.deliver_password_reset_instructions!
      flash[:notice] = I18n.t(:'success.password_reset_instructions_sent')
      redirect_to root_path
    else
      flash[:notice] = I18n.t(:'errors.couldn_sent_password_reset_instructions')
      render :action => :new
    end
  end

  # GET /passwords/1/edit
  def edit
  end

  # PUT /passwords/1
  def update
    @codabra.password = params[:user][:password]
    @codabra.password_confirmation = params[:user][:password_confirmation]
    if @codabra.save
      flash[:notice] = t(:'common.success.updated', model: t(:'entity.password'))
      redirect_to profile_path(@codabra.name)
    else
      flash[:alert] = t(:'common.errors.updated', model: t(:'entity.password'))
      render :edit
    end
  end

private
  def load_codabra_using_password_salt
    @codabra = Codabra.find_by_password_salt(params[:id])
    render status: 404 unless @codabra
  end
end
