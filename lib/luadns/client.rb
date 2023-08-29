# frozen_string_literal: true

module Luadns
  class Client
    DEFAULT_OPTIONS = {
      format: :json,
      headers: {
        "Accept" => JSON_MIME,
        "Content-Type" => JSON_MIME,
        "User-Agent" => USER_AGENT
      }
    }.freeze

    attr_reader :http_client

    attr_reader :users
    attr_reader :zones
    attr_reader :records

    def initialize(username = Luadns.username, password = Luadns.password)
      @http_client = HttpClient.new(request_options(username, password))
      @users = Luadns::Endpoint::Users.new(@http_client)
      @zones = Luadns::Endpoint::Zones.new(@http_client)
      @records = Luadns::Endpoint::Records.new(@http_client)
    end

    protected

    def request_options(username, password)
      DEFAULT_OPTIONS.merge({basic_auth: {username: username, password: password}})
    end
  end
end
