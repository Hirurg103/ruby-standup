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
