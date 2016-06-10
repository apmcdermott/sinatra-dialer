require 'rubygems'
require 'bundler'

require 'twilio-ruby'
require "net/http"
require "uri"

Bundler.require

require './sinatra-dialer'
run Sinatra::Application