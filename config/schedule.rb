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


ROOT = "/home/deploy/miga"
set :output, "#{ROOT}/shared/log/cron.log"

every 1.week do
  command "cd #{ROOT}/current && ~/.rbenv/bin/rbenv exec bundle exec backup perform -c config/Backup/config.rb -t miga_all"
end

every 1.day do
  command "cd #{ROOT}/current && ~/.rbenv/bin/rbenv exec bundle exec backup perform -c config/Backup/config.rb -t miga_db"
end
