require_relative './test_helper'

def create_commit(attrs)
  Rugged::Commit.create(@repo, {
    message: 'Initial commit',
    parents: @repo.empty? ? [] : [@repo.head.target].compact,
    update_ref: 'HEAD',
    tree: @repo.index.write_tree(@repo)
  }.merge(attrs))
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
      create_commit message: 'Add public page for users'
    end

    it 'should include this commit in my standup' do
      StandupMessage.for(@repo_url).must_equal 'Yesterday I add public page for users'
    end
  end
end
