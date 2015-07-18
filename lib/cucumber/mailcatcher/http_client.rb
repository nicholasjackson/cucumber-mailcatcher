require "net/http"
require "net/https"
require "uri"
require 'json'

module Cucumber
  module Mailcatcher

    class HttpClient
      attr_accessor :server_url

      def get_messages
        do_get_json '/messages'
      end

      def get_messages_from_email email
        messages = do_get_json '/messages'

        messages.select { |item|
          item if item["sender"].include?(email)
        }
      end

      def get_messages_to_email email
        messages = do_get_json '/messages'

        messages.select { |item|
          item if item["recipients"].include?(email) || item["recipients"].include?('<' + email + '>')
        }
      end

      def get_messages_with_subject subject
        messages = do_get_json '/messages'

        messages.select { |item|
          item if item["subject"].include?(subject)
        }
      end

      def get_messages_with_html_body body
        messages = do_get_json '/messages'

        messages.select { |item|
          response = do_get "/messages/#{item['id']}.json.html"
          item if response.code != '404' && response.body.include?(body)
        }
      end

      def get_messages_with_plain_body body
        messages = do_get_json '/messages'

        messages.select { |item|
          response = do_get "/messages/#{item['id']}.json.plain"
          item if response.code != '404' && response.body.include?(body)
        }
      end

      def delete_messages
        do_delete '/messages'
        true
      end

      def do_get relative_url
        uri = URI("#{@server_url}#{relative_url}")
        Net::HTTP.get_response(uri)
      end

      def do_get_json relative_url
        JSON.load((do_get relative_url).body )
      end

      def do_delete relative_url
        uri = URI("#{@server_url}#{relative_url}")

        request = Net::HTTP.new(uri.host,uri.port)
        request.delete(uri.path).code
      end
    end

  end
end
