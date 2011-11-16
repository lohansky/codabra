class BattlesController < ApplicationController

  before_filter :login_required, except: :index

  respond_to :html, :json

  # GET /battles
  # GET /battles.json
  def index
    @presenter = Battles::IndexPresenter.new(current_codabra)
  end

  # GET /battles/1
  # GET /battles/1.json
  def show
    @battle = Battle.find(params[:id])

    if @battle.public or current_codabra == @battle.creator
      respond_with(@battle)
    end
  end

  # GET /battles/new
  # GET /battles/new.json
  def new
    @battle = Battle.new
    @battle_types = BattleType.all
    @programs = current_codabra.programs

    respond_with(@battle)
  end

  # POST /battles
  # POST /battles.json
  def create
    @battle_types = BattleType.all
    @battle = current_codabra.battles.new(params[:battle])
    @battle.type = params[:battle][:type]

    respond_to do |format|
      if @battle.save
        format.html { redirect_to arena_path, notice: 'Battle was successfully created.' }
        format.json { render json: @battle, status: :created, location: @battle }
      else
        format.html { render :new }
        format.json { render json: @battle.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /battles/1
  # DELETE /battles/1.json
  def destroy
    @battle = Battle.find(params[:id])
    @battle.destroy

    respond_to do |format|
      format.html { redirect_to battles_url }
      format.json { head :ok }
    end
  end

  # PUT /battles/1/fight
  # PUT /battles/1/fight.json
  def fight
    unless @mq
      @mq = Bunny.new('amqp://localhost:5672')
      @mq.start
    end

    @battle = Battle.find(params[:id])
    @battle.player = current_codabra
    @battle.update_attributes(params[:battle])
    @battle.fight

    respond_to do |format|
      if @battle.save
        @mq.exchange('').publish(@battle.id, key: 'codabra.battles')
        format.html { redirect_to battle_path(@battle) }
        format.json { head :ok }
      else
        format.html { redirect_to arena_path }
        format.json { render json: @battle.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /battles/1/log.json
  def log
    @battle = Battle.find(params[:id])

    respond_to do |format|
      format.json { render json: JSON.generate(status: @battle.status, log: @battle.read_log) }
    end
  end
end
