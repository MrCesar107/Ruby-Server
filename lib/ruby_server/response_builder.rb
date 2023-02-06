require_relative "response"

module RubyServer
  class ResponseBuilder
    attr_reader :root_path

    def initialize(root_path)
      @root_path = root_path
    end

    def prepare(request)
      if request.fetch(:path) == "/"
        respond_with(root_path + "index.html")
      else
        respond_with(root_path + request.fetch(:path))
      end
    end

    def respond_with(path)
      if File.exist?(path)
        send_ok_response(File.binread(path))
      else
        send_file_not_found
      end
    end

    private

    def send_ok_response(data)
      Response.new(code: 200, data: data)
    end

    def send_file_not_found
      Response.new(code: 404)
    end
  end
end
