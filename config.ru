#\ -w -o 0.0.0.0 -p 4567 -s thin
# encoding: utf-8

require File.expand_path('../config/boot.rb', __FILE__)

# noinspection RubyStringKeysInHashInspection
run Rack::URLMap.new({
   '/' => MySinatraApp::App
})
