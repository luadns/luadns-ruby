# frozen_string_literal: true

module Luadns
  # LuadnsError is the base error.
  class LuadnsError < StandardError
    attr_reader :message
    attr_reader :http_body
    attr_reader :http_headers
    attr_reader :http_status

    def initialize(response, message = nil)
      @http_code = response.code
      @http_headers = response.headers
      @http_status = response.code
      @message = message
    end
  end

  class RequestError < LuadnsError
    def initialize(response)
      super(response, JSON.parse(response.body)["message"])
    end
  end

  class ValidationError < LuadnsError
    def initialize(response)
      body = JSON.parse(response.body)
      message = body.map do |t|
        fields = t["fieldNames"]
        message = t["message"]
        "#{fields.join(", ")}: #{message}"
      end.join("; ")
      super(response, message)
    end
  end

  # AuthenticationError is raised when invalid credentials are used.
  class AuthenticationError < RequestError; end

  # NotFoundError is raised when accessing a record that doesn't exist.
  class NotFoundError < LuadnsError
    def initialize(response)
      super(response, "Record not found")
    end
  end

  # RateLimitError is raised when an account issued too many requests.
  # The request must be retried after `reset_at` Unix time.
  class RateLimitError < LuadnsError
    attr_reader :reset_at

    def initialize(response)
      @reset_at = response.headers["X-Ratelimit-Reset"].to_i
      super(response, "Please back off and retry your request at #{@reset_at}")
    end

    # Returns the remaining seconds until rate limits are reset.
    def reset_in
      now = Time.now.to_i
      (now < reset_at) ? reset_at - now : 0
    end
  end

  # ServerError is raised when server returned an unexpected response.
  class ServerError < LuadnsError; end
end
