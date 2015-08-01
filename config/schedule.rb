# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

job_type :rake, "cd :path && RAILS_ENV=:environment bundle exec rake :task :output"

every 12.hours do
  rake "backup:database"
end

every 24.hours do
  rake "projects:update_libs"
end

# Every hour on the half hour send out emails to peeps who we miss
every '30 * * * *' do
  runner "User.contact_people_we_miss"
end

every "15 */8 * * *" do
  runner "User.gather_surveys"
end

#TODO: This is a little scary
every 2.hours do
  # Restart all unicorn processes to combat memory bloat
  command "pkill -QUIT -f 'unicorn worker'"
end

every :sunday, :at => "10:45pm" do
  runner "User.contact_awesome_people"
end

every :saturday, :at => '11pm' do
  rake "report:send"
end
