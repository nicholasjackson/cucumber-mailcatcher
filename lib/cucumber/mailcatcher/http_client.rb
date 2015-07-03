require "net/http"
require "net/https"
require "uri"
require 'json'

module Cucumber
  module Mailcatcher

    class HttpClient
      attr_accessor :server_url

      def get_messages
        do_get '/messages'
      end

      def delete_messages
        do_delete '/messages'

        true
      end

      def do_get relative_url
        uri = URI("#{@server_url}#{relative_url}")
        Net::HTTP.get(uri)
      end

      def do_delete relative_url
        uri = URI("#{@server_url}#{relative_url}")
        p uri
        request = Net::HTTP.new(uri.host,uri.port)
        request.delete(uri.path).code
      end
    end

  end
end
