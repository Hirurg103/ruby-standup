require 'thor'

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'standup_message'

class Standup < Thor
  desc "generate" ,"generates my standup based on my yesterday's commits"
  def generate
    puts standup_message
  end

  no_commands do
    def standup_message
      StandupMessage.generate
    end
  end
end

Standup.start(ARGV)
