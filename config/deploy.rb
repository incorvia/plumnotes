# RVM

$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
require "rvm/capistrano"
set :rvm_ruby_string, 'default'
set :rvm_type, :user

# Bundler

require "bundler/capistrano"

# General

set :application, "notes"
set :user, "kevin"

set :deploy_to, "/home/#{user}/#{application}"
set :deploy_via, :copy

set :use_sudo, false

# Git

set :scm, :git
set :repository,  "git@github.com:/incorvia/notes.git"
set :branch, "master"

# VPS

role :web, "96.8.120.141"
role :app, "96.8.120.141"
role :db,  "96.8.120.141", :primary => true
role :db,  "96.8.120.141"

# Precompile Assets

#after 'deploy:update_code', 'deploy:compile_assets'
#namespace :deploy do
#  task :compile_assets do
#    run "cd #{release_path}; RAILS_ENV=production rake assets:precompile"
#  end
#end


# Passenger

namespace :deploy do
 task :start do ; end
 task :stop do ; end
 task :restart, :roles => :app, :except => { :no_release => true } do
   run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
 end
end


