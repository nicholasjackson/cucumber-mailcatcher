module Cucumber
  module Mailcatcher
    class Api
      def initialize http_client
        @http = http_client
      end

      def get_messages
        @http.do_get_json '/messages'
      end

      def get_messages_from_email email
        messages = get_messages

        messages.select { |item|
          item if item["sender"].include?(email)
        }
      end

      def get_messages_to_email email
        messages = get_messages

        messages.select { |item|
          item if item["recipients"].include?(email) || item["recipients"].include?('<' + email + '>')
        }
      end

      def get_messages_with_subject subject
        messages = get_messages

        messages.select { |item|
          item if item["subject"].include?(subject)
        }
      end

      def get_messages_with_html_body body
        messages = get_messages

        messages.select { |item|
          response = @http.do_get "/messages/#{item['id']}.json.html"
          item if response.code != '404' && response.body.include?(body)
        }
      end

      def get_messages_with_plain_body body
        messages = get_messages

        messages.select { |item|
          response = @http.do_get "/messages/#{item['id']}.json.plain"
          item if response.code != '404' && response.body.include?(body)
        }
      end

      def delete_messages
        @http.do_delete '/messages'
        true
      end
    end
  end
end
