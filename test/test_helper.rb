# test_helper.rb
ENV['RACK_ENV'] = 'test'
require 'minitest/autorun'
require 'rack/test'

Rack::Builder.new do
  eval File.read(('config.ru'))
end

set :root, File.dirname('../')
#require File.expand_path '../../sinatra-dialer.rb', __FILE__