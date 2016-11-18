set :bundle_without, 'development test'
server '193.70.36.61',
  roles: %w(app web db)
set :application, 'ticketownik'
set :branch, 'master'
set :user, 'michal'

set :deploy_to, '/home/michal/apps/ticketownik'
set :deploy_env, 'production'
set :rails_env, 'production'
set :port, 22
set :use_sudo, false
set :ssh_options, {
    config: false,
    forward_agent: true
}
