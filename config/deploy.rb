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
    on roles(:all) do
      within current_path do
        if test('[ -f /tmp/arkaan.pid ]')
          puts 'Le fichier du PID a bien été trouvé et va être supprimé.'
          execute :kill, '-9 `cat /tmp/arkaan.pid`'
        else
          puts "Le fichier du PID n'a pas été trouvé et ne peux pas être supprimé."
        end
        execute :bundle, 'exec rackup -p 9292 --env production -o 0.0.0.0 -P /tmp/arkaan.pid --daemonize'
      end
    end
  end
end