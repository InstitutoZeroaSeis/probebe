set :application, 'pro-bebe'
set :deploy_user, 'deploy'
set :use_sudo, true

# setup repo details
set :scm, :git
set :repo_url, 'git@bitbucket.org:myvizir/pro-bebe.git'

# assets (deu pau)
set :assets_roles, [:app]

# setup rbenv.
#set :rbenv_type, :system
#set :rbenv_ruby, '2.1.1'
#set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
#set :rbenv_map_bins, %w{rake gem bundle ruby rails}

# setup rvm
############# rvm 1 #######
#no config

############# rvm capistrano
# deploy.rb or stage file (staging.rb, production.rb or else)
#set :rvm_type, :system                     # Defaults to: :auto
#set :rvm_ruby_version, '2.0.0-p481'      # Defaults to: 'default'
#set :rvm_custom_path, '~/.myveryownrvm'  # only needed if not detected

# seting ssh Agent

set :rvm1_ruby_version, "ruby-2.1.3"

set :ssh_options, { :forward_agent => true }
#ssh_options[:keys] = %w(.ssh/id_rsa .ssh/deploy_key)

# how many old releases do we want to keep, not much
set :keep_releases, 1

# files we want symlinking to specific entries in shared
set :linked_files, %w{config/database.yml}

# dirs we want symlinking to shared
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# what specs should be run before deployment is allowed to
# continue, see lib/capistrano/tasks/run_tests.cap
set :tests, []

#set :rvm1_ruby_version, "ruby-2.0.0-p481"

# which config files should be copied by deploy:setup_config
# see documentation in lib/capistrano/tasks/setup_config.cap
# for details of operations
set(:config_files, %w(
  nginx.conf
  database.example.yml
  log_rotation
  unicorn.rb
  unicorn_init.sh
))

# which config files should be made executable after copying
# by deploy:setup_config
set(:executable_config_files, %w(
  unicorn_init.sh
))


# files which need to be symlinked to other parts of the
# filesystem. For example nginx virtualhosts, log rotation
# init scripts etc. The full_app_name variable isn't
# available at this point so we use a custom template {{}}
# tag and then add it at run time.
set(:symlinks, [
  {
    source: "nginx.conf",
    link: "/etc/nginx/sites-enabled/{{full_app_name}}"
  },
  {
    source: "unicorn_init.sh",
    link: "/etc/init.d/unicorn_{{full_app_name}}"
  },
  {
    source: "log_rotation",
   link: "/etc/logrotate.d/{{full_app_name}}"
  },
#  {
#    source: "monit",
#    link: "/etc/monit/conf.d/{{full_app_name}}.conf"
#  }
])

# this:
# http://www.capistranorb.com/documentation/getting-started/flow/
# is worth reading for a quick overview of what tasks are called
# and when for `cap stage deploy`

namespace :deploy do
  # make sure we're deploying what we think we're deploying
  before :deploy, "deploy:check_revision"
  # only allow a deploy with passing tests to deployed
  before :deploy, "deploy:run_tests"

  # Install missing ruby
  before 'deploy', 'rvm1:install:ruby'  # install/update Ruby

  # compile assets locally then rsync
  # after 'deploy:symlink:shared', 'deploy:compile_assets_locally'
  after :finishing, 'deploy:cleanup'

  # remove the default nginx configuration as it will tend
  # to conflict with our configs.
  before 'deploy:setup_config', 'nginx:remove_default_vhost'

  # reload nginx to it will pick up any modified vhosts from
  # setup_config
  after 'deploy:setup_config', 'nginx:reload'

  # Restart monit so it will pick up any monit configurations
  # we've added
  #after 'deploy:setup_config', 'monit:restart'

  # As of Capistrano 3.1, the `deploy:restart` task is not called
  # automatically.
  after 'deploy:publishing', 'deploy:restart'
end