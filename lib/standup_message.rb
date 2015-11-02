class StandupMessage
  def self.generate
    "Yesterday I din't work too much"
  end

  def self.for(repo_url)
    'Yesterday I ' + commit_messages_for(repo_url).join(', ').downcase
  end

  def self.commit_messages_for(repo_url)
    commit_messages = []
    Rugged::Repository.new(repo_url).walk('HEAD') do |commit|
      commit_messages << commit.message
    end
    commit_messages.reverse
  end
end
