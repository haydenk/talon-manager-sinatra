require 'sinatra/base'
require 'base64'

module Sinatra
  module ApplicationHelpers
    def create_basic_credentials(username, password)
      encoded_value = Base64.encode64("#{username}:#{password}")
      {
          :location => 'header',
          :field => 'Authorization',
          :value => "Basic #{encoded_value}".strip,
      }
    end
  end
end