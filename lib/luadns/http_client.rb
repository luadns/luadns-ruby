# frozen_string_literal: true

module Luadns
  class HttpClient
    def initialize(options = {})
      @options = options
    end

    # Make a HTTP GET request.
    def get(url, options = {})
      yield http_request(:get, url, nil, request_options(options))
    end

    # Make a HTTP POST request.
    def post(url, data = nil, options = {})
      yield http_request(:post, url, data, request_options(options))
    end

    # Make a HTTP PUT request.
    def put(url, data = nil, options = {})
      yield http_request(:put, url, data, request_options(options))
    end

    # Make a HTTP DELETE request.
    def delete(url, options = {})
      yield http_request(:delete, url, nil, request_options(options))
    end

    private

    def http_request(method, url, data = nil, options = {})
      request_type = options.dig(:headers, "Content-Type")
      options = options.merge(body: encode_body(data, request_type)) if data
      HTTParty.send(method, url, options)
    end

    def encode_body(data, content_type)
      (content_type == JSON_MIME) ? JSON.dump(data) : data
    end

    def request_options(options)
      @options.merge(options)
    end
  end
end
