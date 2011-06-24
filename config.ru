require "rubygems"
require "bundler"
require 'sinatra/base'
require 'dalli'
require 'rack/cache'
Bundler.setup

class RackCacheDemoApp < Sinatra::Base

  use Rack::Cache,
    :verbose => true,
    :metastore => "memcached://#{ENV['MEMCACHE_SERVERS']}",
    :entitystore => "memcached://#{ENV['MEMCACHE_SERVERS']}"

  get "/" do
    cache_control :public, :max_age => 15
    "Cached at #{Time.now.to_s}"
  end
end

run RackCacheDemoApp
