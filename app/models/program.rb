class Program < ActiveRecord::Base

  belongs_to :owner, class_name: 'Codabra'
  belongs_to :battle_type, foreign_key: :battle_class, primary_key: :battle_class

  has_many :won_battles, class_name: 'Battle', foreign_key: :winner_program_id

  validates_presence_of :battle_class
  validates_presence_of :owner_id
  validates_presence_of :name
  validate :check_syntax

  def check_syntax
    execute(nil, "-c")
  end

  def execute(params = nil, opts = nil)
    create_file

    output = Executor::exec("ruby #{opts} #{@tmppath} #{params} 2>&1")
    rc = $?.clone
    unless $?.success?
      errors.add(:code, output)
    end

    remove_file

    [rc, output]
  end

  def wins_count
    self.won_battles.where(public: true).count
  end

private

  def base_file_path
    "/tmp/program-#{self.id}"
  end

  def create_file
    @tmppath = Executor::exec("mktemp #{base_file_path}-XXXXXXXX").chomp

    f = File.open(@tmppath, "w")
    f.write(self.code)
    f.close

    @tmppath
  end

  def remove_file
    File.unlink(@tmppath)
  end

end
