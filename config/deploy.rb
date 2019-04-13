lock '~> 3.11.0'

set :application, 'arkaan-notifications'
set :deploy_to, '/var/www/arkaan-notifications'

set :repo_url, 'git@github.com:jdr-tools/notifications.git'
set :branch, 'master'

append :linked_files, 'config/mongoid.yml'

append :linked_dirs, 'bundle'

namespace :deploy do
  desc 'Start the server'
  after :finishing, :start do
    run "cd #{deploy_to};if [ -f tmp/pids/arkaan.pid ] && [ -e /proc/$(cat tmp/pids/arkaan.pid) ]; then kill -9 `cat tmp/pids/arkaan.pid`; fi"
    run "cd #{deploy_to}; RACK_ENV=production bundle exec rackup -o 0.0.0.0 -p 80 --env production -P tmp/pids/arkaan.pid"
  end
end