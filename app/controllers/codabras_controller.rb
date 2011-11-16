class CodabrasController < ApplicationController
  before_filter :login_required, only: :edit
  before_filter :no_login_required, only: [:new, :create]

  respond_to :html, :json

  # GET /codabras
  # GET /codabras.json
  def index
    @codabras = Codabra.champions

    respond_with(@codabras)
  end

  # GET /codabras/1
  # GET /codabras/1.json
  def show
    if params[:name]
      @codabra = Codabra.find_by_name(params[:name])
    else
      @codabra = Codabra.find(params[:id])
    end

    respond_with(@codabra)
  end

  # GET /codabras/new
  # GET /codabras/new.json
  def new
    @codabra = Codabra.new

    respond_with(@codabra)
  end

  # GET /codabras/1/edit
  def edit
    if params[:name]
      @codabra = Codabra.find_by_name(params[:name])
    else
      @codabra = Codabra.find(params[:id])
    end
  end

  # POST /codabras
  # POST /codabras.json
  def create
    @codabra = Codabra.new(params[:codabra])
    @codabra.active = true

    respond_to do |format|
      if @codabra.save
        format.html { redirect_to profile_path(@codabra.name), notice: t(:'registration.success') }
        format.json { render json: @codabra, status: :created, location: @codabra }
      else
        format.html { render :new, alert: t(:'registration.errors') }
        format.json { render json: @codabra.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /codabras/1
  # PUT /codabras/1.json
  def update
    @codabra = Codabra.find(params[:id])

    respond_to do |format|
      if @codabra.update_attributes(params[:codabra])
        I18n.locale = LocaleDispatcher.locale(@codabra)

        format.html { redirect_to profile_path(@codabra.name), notice: t(:'codabra.update.success') }
        format.json { head :ok }
      else
        format.html { render :edit }
        format.json { render json: @codabra.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /codabras/1
  # DELETE /codabras/1.json
  def destroy
    @codabra = Codabra.find(params[:id])

    respond_to do |format|
      format.html { redirect_to codabras_url }
      format.json { head :ok }
    end
  end
end
