class Battle < ActiveRecord::Base
  include AASM

  belongs_to :battle_type, foreign_key: :type, primary_key: :battle_class
  belongs_to :creator, class_name: 'Codabra'
  belongs_to :creator_program, class_name: 'Program'
  belongs_to :player, class_name: 'Codabra'
  belongs_to :player_program, class_name: 'Program'
  belongs_to :winner, class_name: 'Codabra'
  belongs_to :winner_program, class_name: 'Program'

  aasm_column :status
  aasm_initial_state :new

  aasm_state :new
  aasm_state :fighting
  aasm_state :finished

  aasm_event :fight do
    transitions from: [:new], to: :fighting
  end

  aasm_event :run do
    transitions from: [:fighting], to: :finished, guard: :do_run
  end

  validates_presence_of :creator_id
  validates_presence_of :creator_program_id
  validates_presence_of :status

  def read_log
    content = nil
    if File.exists?(log_path)
       File.open(log_path, "r") { |f| content = f.read }
    end
    content
  end

protected

  def clear_log
    File.unlink(log_path) if File.exists?(log_path)
  end

  def write_log(message)
    File.open(log_path, "a+") { |f| f.puts(message) }
  end

  def do_run
    nil
  end

private

  def log_path
    "/tmp/battle-log-#{self.id}"
  end

end
