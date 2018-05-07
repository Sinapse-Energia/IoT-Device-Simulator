# frozen_string_literal: true

require 'resque/tasks'
require 'resque/scheduler/tasks'

task 'resque:setup' => :environment do
  ENV['QUEUE'] = '*'
end

task 'resque:scheduler_setup' => :environment

desc 'Alias for resque:work (To run workers on Heroku)'
task 'jobs:work' => 'resque:work'

namespace :resque do
  task setup: :environment do
    require 'resque'
    require 'resque/scheduler'
    require 'resque/scheduler/server'

    _ = ENV['RAILS_ROOT'] || File.dirname(__FILE__) + '/../..'
    _ = ENV['RAILS_ENV'] || 'development'
    Resque.redis = Redis.current
  end

  task setup_schedule: :setup do
    require 'resque-scheduler'

    Resque::Scheduler.dynamic = true
    Resque.schedule = YAML.load_file(File.join(Rails.root, 'config/resque_schedule.yml'))
  end

  task scheduler: :setup_schedule
end
