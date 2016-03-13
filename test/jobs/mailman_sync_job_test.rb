require 'test_helper'
require 'minitest/mock'

class MailmanSyncJobTest < ActiveJob::TestCase
  def test_perform_correct_users
    stdin = StringIO.new
    Open4.stub(:popen4, OpenStruct.new(success?: true), [0, stdin, StringIO.new, StringIO.new]) do
      job = MailmanSyncJob.new
      job.perform('discuss')
    end

    assert_equal(%w(admin@example.com regular@example.com).join("\n") + "\n", stdin.string)
  end
end