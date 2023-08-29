module Luadns
  module Endpoint
    class Base
      attr_reader :http_client

      def initialize(http_client)
        @http_client = http_client
      end

      def endpoint_url(path)
        "#{Luadns.base_url}#{path}"
      end

      def parse_response(response, object_class)
        content_type = response.headers.fetch("Content-Type", "")
        unless content_type.start_with?(JSON_MIME)
          raise ServerError, response, "Unexpected Content-Type: #{content_type.inspect}"
        end

        case response.code
        when 200
          JSON.parse(response.body, object_class: object_class)
        when 400
          raise ValidationError, response
        when 401
          raise AuthenticationError, response
        when 403
          raise RequestError, response
        when 404
          raise NotFoundError, response
        when 429
          raise RateLimitError, response
        else
          raise ServerError, response, "Unexpected status code: #{response.code}"
        end
      end
    end
  end
end
