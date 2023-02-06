# This is the implementation of the web server that will be used to serve the client requests.

require "socket"

module RailsServer
  class Server
    def run
      server = TCPServer.new("localhost", 8080)

      loop {
        client = server.accept
        request = client.readpartial(2048)

        puts request
      }
    end
  end
end
