# Load DSL and set up stages
require "capistrano/setup"

# Include default deployment tasks
require "capistrano/deploy"
require 'capistrano/rails'
# Load the SCM plugin appropriate to your project:
require "capistrano/scm/git"
install_plugin Capistrano::SCM::Git

# Include tasks for rbenv and bundler
#require "capistrano/rbenv"        # Ruby version manager
require 'capistrano/rvm'
require "capistrano/bundler"      # For managing gems

# Set Ruby version for rbenv
set :rvm_ruby_version, '3.3.3'          # Replace with the Ruby version you need

# Ensure gems are installed with bundler during deployment
set :bundle_flags, '--deployment'

# Load custom tasks from `lib/capistrano/tasks` if you have any defined
Dir.glob("lib/capistrano/tasks/*.rake").each { |r| import r }
