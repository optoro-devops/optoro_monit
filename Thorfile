# encoding: utf-8

require 'bundler'
require 'bundler/setup'
require 'berkshelf/thor'
require 'thor/foodcritic'

begin
  require 'kitchen/thor_tasks'
  Kitchen::ThorTasks.new
rescue LoadError
  puts ">>>>> Kitchen gem not loaded, omitting tasks" unless ENV['CI']
end

class Default < Thor
  desc 'chefspec', 'runs chefspec tests on current cookbook'
  def chefspec
    `bundle exec rspec`
  end

  desc 'test_all', 'runs foodcritic, chefspec, and kitchen on current cookbook'
  def test_all
    invoke 'foodcritic:lint'
    invoke 'chefspec'
    invoke 'kitchen:all'
  end
end
