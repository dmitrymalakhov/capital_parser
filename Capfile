#$:.unshift(File.expand_path('./lib', ENV['rvm_path'])) # Add RVM's lib directory to the load path.
require "rvm/capistrano" # Load RVM's capistrano plugin.
require "bundler/capistrano"

set :rvm_ruby_string, 'ruby-1.9.3-p392@capital_parser' # Or whatever env you want it to run in.

require 'capistrano-deploy'
use_recipes :git, :rails, :bundle, :unicorn

server '188.225.32.92', :web, :app, :db, :primary => true
set :user, 'madgest'
set :deploy_to, '/home/madgest/capital_parser'
set :repository, 'https://github.com/dmitrymalakhov/quicktouch.git' #'git@github.com:dmitrymalakhov/quicktouch.git'

ssh_options[:forward_agent] = true
default_run_options[:pty] = true

after 'deploy:update', 'bundle:install'