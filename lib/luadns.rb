# frozen_string_literal: true

# Module for interacting with LuaDNS API.
module Luadns
  BASE_URL = "https://api.luadns.com/v1"
  JSON_MIME = "application/json"
  USER_AGENT = "luadns-ruby/#{VERSION}".freeze

  class << self
    attr_writer :base_url
    attr_accessor :username, :password

    def base_url
      @base_url || BASE_URL
    end

    def configure
      yield self
    end
  end
end

require "httparty"
require_relative "luadns/errors"
require_relative "luadns/schema"
require_relative "luadns/schema/base"
require_relative "luadns/schema/user"
require_relative "luadns/schema/zone"
require_relative "luadns/schema/record"
require_relative "luadns/http_client"
require_relative "luadns/endpoint"
require_relative "luadns/endpoint/base"
require_relative "luadns/endpoint/users"
require_relative "luadns/endpoint/zones"
require_relative "luadns/endpoint/records"
require_relative "luadns/client"
