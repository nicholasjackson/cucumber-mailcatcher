require "net/http"
require "net/https"
require "uri"
require 'json'

module Cucumber
  module Mailcatcher

    class HttpClient
      attr_accessor :server_url

      def get_messages
        make_request '/messages'
      end

      def make_request relative_url
        uri = URI("#{@server_url}#{relative_url}")
        Net::HTTP.get(uri)
      end
    end
    
  end
end
