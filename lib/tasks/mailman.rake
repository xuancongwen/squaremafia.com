require 'securerandom'

namespace :mailman do

  desc 'create a new mailman list and corresponding db entry'
  task :newlist => :environment do
    print 'List name: '
    name = $stdin.gets.chomp

    print 'Admin email: '
    email = $stdin.gets.chomp

    print 'Description: '
    description = $stdin.gets.chomp

    password = SecureRandom.hex
    puts "List admin password: #{password}"

    puts `/usr/lib/mailman/bin/newlist -q '#{name}' '#{email}' '#{password}'`
    raise 'An error occurred. See output?' unless $?.success?

    MailingList.create!(name: name, description: description)
  end

  desc 'sync subscriptions for all lists'
  task :sync => :environment do
    MailmanSyncJob.perform_now
  end
end