#!/usr/bin/env ruby

ENV["RAILS_ENV"] ||= "development"

require File.dirname(__FILE__) + "/../../config/application"
Rails.application.require_environment!

queue_name = 'codabra.battles'

logger = Logger.new(File.join(Rails.root, 'log', 'battlesd.log'))
logger.level = Logger::DEBUG

Object.const_set 'RAILS_DEFAULT_LOGGER', logger unless Rails.env == 'test'
Rails.logger = logger
ActiveRecord::Base.logger = logger

logger.info("Started")

def process_battle(battle)
  Rails.logger.info("Starting battle #{battle.inspect}")
  battle.run
  battle.save
  Rails.logger.info("Battle #{battle.id} is finished")
end

AMQP.start(host: "localhost") do |connection|
  channel = AMQP::Channel.new(connection)
  queue = channel.queue(queue_name)
  logger.info("Joined to queue #{queue_name}")

  Signal.trap("TERM") do
    connection.close do
      EM.stop
    end
  end

  queue.subscribe do |battle_id|
    battle = Battle.find(battle_id)
    process_battle(battle)
  end
end

logger.info("Terminated")
exit
