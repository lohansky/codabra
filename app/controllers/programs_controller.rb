class ProgramsController < ApplicationController

  before_filter :login_required
  before_filter :ownership_requied, only: [:show, :edit, :update, :destroy]

  respond_to :html, :json

  # GET /programs
  # GET /programs.json
  def index
    @programs = current_codabra.programs.all

    respond_with(@programs)
  end

  # GET /programs/1
  # GET /programs/1.json
  def show
    @program = Program.find(params[:id])

    respond_with(@program)
  end

  # GET /programs/new
  # GET /programs/new.json
  def new
    @program = Program.new
    @battle_types = BattleType.all

    respond_with(@program)
  end

  # GET /programs/1/edit
  def edit
    @program = Program.find(params[:id])
    @battle_types = BattleType.all
  end

  # POST /programs
  # POST /programs.json
  def create
    @program = current_codabra.programs.new(params[:program])

    respond_to do |format|
      if @program.save
        format.html { redirect_to @program, notice: 'Program was successfully created.' }
        format.json { render json: @program, status: :created, location: @program }
      else
        format.html { render :new }
        format.json { render json: @program.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /programs/1
  # PUT /programs/1.json
  def update
    @program = Program.find(params[:id])
    @battle_types = BattleType.all

    respond_to do |format|
      if @program.update_attributes(params[:program])
        format.html { redirect_to @program, notice: 'Program was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :edit }
        format.json { render json: @program.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /programs/1
  # DELETE /programs/1.json
  def destroy
    @program = Program.find(params[:id])
    @program.destroy

    respond_to do |format|
      format.html { redirect_to programs_url }
      format.json { head :ok }
    end
  end

  # GET /programs/1/test
  # GET /programs/1/test.json
  def test
    unless @mq
      @mq = Bunny.new('amqp://localhost:5672')
      @mq.start
    end

    program = Program.find(params[:id])
    splinter = Codabra.find_by_name('splinter')

    @battle = current_codabra.battles.new(
      creator_program: program,
      player: splinter,
      player_program: splinter.programs.where(battle_class: program.battle_class).first,
      public: false
    )
    @battle.type = program.battle_class
    @battle.fight

    respond_to do |format|
      if @battle.save
        @mq.exchange('').publish(@battle.id, key: 'codabra.battles')
        format.html { redirect_to battle_path(@battle) }
        format.json { head :ok }
      else
        format.html { redirect_to programs }
        format.json { render json: @battle.errors, status: :unprocessable_entity }
      end
    end
  end

private

  def ownership_requied
    redirect_to programs_path unless current_codabra == Program.find(params[:id]).owner
  end

end
