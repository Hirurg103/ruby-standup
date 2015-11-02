require_relative './test_helper'

describe StandupMessage do
  describe 'when I made only commit yesterday' do
    repo_url = File.expand_path('../fixtures/with_1_commit_yesterday', __FILE__)
    FileUtils.rm_rf repo_url
    FileUtils.mkdir_p repo_url
    repo = Rugged::Repository.init_at(repo_url)

    Rugged::Commit.create(repo, {
      message: 'Add public page for users',
      parents: repo.empty? ? [] : [repo.head.target].compact,
      update_ref: 'HEAD',
      tree: repo.index.write_tree(repo)
    })

    it 'should include this commit in my standup' do
      StandupMessage.for(repo_url).must_equal 'Yesterday I add public page for users'
    end
  end
end
