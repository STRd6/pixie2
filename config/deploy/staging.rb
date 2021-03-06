# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary
# server in each group is considered to be the first
# unless any hosts have the primary property set.
# Don't declare `role :all`, it's a meta role
deploy = "rails@107.170.229.143"

role :app, deploy
role :web, deploy
role :db, deploy

set :whenever_environment, 'staging'

set :application, "staging.pixieengine.com"
set :deploy_to, '/var/www/staging.pixieengine.com'
set :repo_url, 'git://github.com/STRd6/pixie2.git'

set :rvm_ruby_version, "2.2.2"

task :copy_staging_nginx_conf do
  on roles(:web) do
    execute "cp #{release_path}/config/nginx.staging.conf #{release_path}/config/nginx.conf"
  end
end

before "deploy:finished", :copy_staging_nginx_conf

# Extended Server Syntax
# ======================
# This can be used to drop a more detailed server
# definition into the server list. The second argument
# something that quacks like a hash can be used to set
# extended properties on the server.
# server 'example.com', user: 'deploy', roles: %w{web app}, my_property: :my_value

# you can set custom ssh options
# it's possible to pass any option but you need to keep in mind that net/ssh understand limited list of options
# you can see them in [net/ssh documentation](http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start)
# set it globally
#  set :ssh_options, {
#    keys: %w(/home/rlisowski/.ssh/id_rsa),
#    forward_agent: false,
#    auth_methods: %w(password)
#  }
# and/or per server
# server 'example.com',
#   user: 'user_name',
#   roles: %w{web app},
#   ssh_options: {
#     user: 'user_name', # overrides user setting above
#     keys: %w(/home/user_name/.ssh/id_rsa),
#     forward_agent: false,
#     auth_methods: %w(publickey password)
#     # password: 'please use keys'
#   }
# setting per server overrides global ssh_options
