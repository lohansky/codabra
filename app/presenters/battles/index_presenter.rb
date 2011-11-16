class Battles::IndexPresenter
  def initialize(codabra)
    @codabra = codabra
  end

  def my_battles
    @codabra.battles.where(status: :new)
  end

  def new_battles
    if @codabra
      Battle.where("status = 'new' and creator_id != #{@codabra.id}")
    else
      Battle.where(status: 'new')
    end
  end

  def fighting_battles
    Battle.where(status: :fighting)
  end

  def recent_battles
    Battle.where(status: :finished, public: true).order('updated_at desc').limit(10)
  end

  def my_programs
    @codabra.programs.all
  end
end