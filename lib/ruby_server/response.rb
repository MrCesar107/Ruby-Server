module RubyServer
  class Response
    attr_reader :code

    def initialize(code:, data: "")
      @response = "HTTP/1.1 #{code}\r\n" +
      "\r\n" +
      "#{data}\r\n"
      @code = code
    end

    def send(client)
      client.write(@response)
    end
  end
end
