# frozen_string_literal: true

# Resque.redis = Redis::Namespace.new(:resque, :redis => $redis)

Dir['/app/app/jobs/*.rb'].each { |file| require file }
#
# if ENV["REDISCLOUD_URL"]
#   uri = URI.parse(ENV["REDISCLOUD_URL"])
#   Resque.redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password, :thread_safe => true)
# end

Resque.redis = Redis.current
