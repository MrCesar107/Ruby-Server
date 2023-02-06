module RubyServer
  class RequestParser
    def parse(request)
      method, path, version = request.lines.fisrt.split

      {
        path: path,
        method: method,
        headers: parse_headers(request)
      }
    end

    def parse_headers(request)
      headers = {}
      request.lines[1..-1].each do |line|
        return headers if line == "\r\n"

        header, value = line.split
        header = normilize(header)
        headers[header] = value
      end
    end

    private

    def normalize(header)
      header.gsub(":", "").downcase.to_sym
    end
  end
end
