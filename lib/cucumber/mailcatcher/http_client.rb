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

      def get_messages_from_email email
        messages = do_get '/messages'

        messages.select { |item|
          item if item["sender"].include?(email)
        }
      end

      def get_messages_to_email email
        messages = do_get '/messages'

        messages.select { |item|
          item if item["recipients"].include?(email) || item["recipients"].include?('<' + email + '>')
        }
      end

      def delete_messages
        do_delete '/messages'
        true
      end

      def do_get relative_url
        uri = URI("#{@server_url}#{relative_url}")
        JSON.load(Net::HTTP.get(uri))
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
