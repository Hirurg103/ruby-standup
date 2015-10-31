class StandupMessage
  def self.for(repo_url)
    commit_messages = commit_messages_for(repo_url)
    if commit_messages.any?
      'Yesterday I ' + commit_messages.join(', ').downcase
    else
      didnt_work_too_much
    end
  end

  def self.didnt_work_too_much
    "Yesterday I didn't work too much"
  end

  def self.commit_messages_for(repo_url)
    commit_messages = []
    Rugged::Repository.new(repo_url).walk('HEAD') do |commit|
      if commit.author[:time].between? 1.day.ago.beginning_of_day, 1.day.ago.end_of_day
        commit_messages << commit.message.lines.first.strip
      end
    end

    commit_messages.reverse
  end
end
