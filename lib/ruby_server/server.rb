# This is the implementation of the web server that will be used to serve the client requests.

require "socket"

require_relative "request_parser"
require_relative "response_builder"

module RubyServer
  class Server
    SERVER_ROOT = "tmp/web-server/"
    SERVER_PORT = 8080

    def run
      tcp_server = TCPServer.new("localhost", SERVER_PORT)

      puts "Listening on port #{SERVER_PORT}..."

      loop {
        client = tcp_server.accept
        request = client.readpartial(2048)

        request = RequestParser.new.parse(request)
        response = ResponseBuilder.new(SERVER_ROOT).prepare(request)

        puts "#{client.peeraddr[3]} #{request.fetch(:path)} - #{response.code}"

        response.send(client)
        client.close
      }
    end
  end
end
