require 'rubygems'
require 'bundler'
require 'twilio-ruby'

Bundler.require

require './sinatra-dialer'
run Sinatra::Application