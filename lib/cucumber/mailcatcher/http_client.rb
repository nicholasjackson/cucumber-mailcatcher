require "net/http"
require "net/https"
require "uri"
require 'json'

module Cucumber
  module Mailcatcher

    class HttpClient
      @@server_url = nil

      def self.server_url
        @@server_url
      end

      def self.server_url=server_url
        @@server_url = server_url
      end

      def initialize
        error = "Please set the Mailcatcher server url e.g. Cucumber::Mailcatcher::HttpClient.server_url = 'http://localhost:1080'"

        valid = @@server_url =~ /\A#{URI.regexp(%w(http https))}\z/

        raise error unless valid
      end

      def do_get relative_url
        uri = URI("#{@@server_url}#{relative_url}")
        Net::HTTP.get_response(uri)
      end

      def do_get_json relative_url
        JSON.load((do_get relative_url).body)
      end

      def do_delete relative_url
        uri = URI("#{@@server_url}#{relative_url}")

        request = Net::HTTP.new(uri.host,uri.port)
        request.delete(uri.path).code
      end
    end

  end
end
