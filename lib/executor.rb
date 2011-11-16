module Executor

  class << self
    def exec(cmd)
      Rails.logger.debug("Trying to execute: #{cmd}")
      output = %x[#{cmd}]
      Rails.logger.debug("Executed(rc=#{$?.exitstatus}): #{cmd}\n#{output.chomp}")
      output
    end
  end
end