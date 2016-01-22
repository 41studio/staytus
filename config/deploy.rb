# config valid only for current version of Capistrano
lock '3.4.0'

# set :application, 'my_app_name'
# set :repo_url, 'git@example.com:me/my_repo.git'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, '/var/www/my_app_name'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')
set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml', 'config/environment.yml')


# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :deploy do

  desc "Upload yml file."
  task :upload_yml do
    on roles(:app) do
      execute "mkdir -p #{shared_path}/config"
      upload! StringIO.new(File.read("config/secrets.yml.example")), "#{shared_path}/config/secrets.yml"
      upload! StringIO.new(File.read("config/database.yml.example")), "#{shared_path}/config/database.yml"
      upload! StringIO.new(File.read("config/environment.yml.example")), "#{shared_path}/config/environment.yml"
    end
  end

end