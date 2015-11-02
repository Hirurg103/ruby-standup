require_relative './test_helper'

def create_commit(attrs)
  Rugged::Commit.create(@repo, {
    message: 'Initial commit',
    parents: @repo.empty? ? [] : [@repo.head.target].compact,
    update_ref: 'HEAD',
    tree: @repo.index.write_tree(@repo),
    author: { time: Time.now, email: 'me@example.org', name: 'Me' }
  }.deep_merge(attrs))
end

describe StandupMessage do
  before do
    @repo_url = File.expand_path('../fixtures/with_1_commit_yesterday', __FILE__)
    FileUtils.mkdir_p @repo_url
    @repo = Rugged::Repository.init_at(@repo_url)
  end

  after do
    FileUtils.rm_rf @repo_url
  end

  describe 'when I made only commit yesterday' do
    before do
      create_commit message: 'Add public page for users', author: { time: 1.day.ago }
    end

    it 'should include this commit in my standup' do
      StandupMessage.for(@repo_url).must_equal 'Yesterday I add public page for users'
    end
  end

  describe 'when I made two commits yesterday' do
    before do
      create_commit message: 'Add public page for users', author: { time: 1.day.ago }
      create_commit message: 'Refactor the public pages controller', author: { time: 1.day.ago }
    end

    it 'should include this commit in my standup' do
      StandupMessage.for(@repo_url).must_equal 'Yesterday I add public page for users, refactor the public pages controller'
    end
  end

  describe "when I did't do any commits yesterday" do
    before do
      create_commit message: 'Add public page for users', author: { time: 2.days.ago }
    end

    it 'should include this commit in my standup' do
      StandupMessage.for(@repo_url).must_equal "Yesterday I didn't work too much"
    end
  end
end
