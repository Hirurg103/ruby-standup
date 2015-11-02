lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'standup_message'

require 'bundler'
Bundler.require(:default)

class Standup < Thor
  desc "generate_for repo_url" ,"generates my standup based on my yesterday's commits"
  def generate_for(repo_url)
    puts standup_message_for(repo_url)
  end

  no_commands do
    def standup_message_for(repo_url)
      StandupMessage.for(repo_url)
    end
  end
end

Standup.start(ARGV)
