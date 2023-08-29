module Luadns
  module Endpoint
    class Users < Base
      def initialize(http_client)
        super(http_client)
      end

      # Gets current user.
      #
      # @see http://www.luadns.com/api.html#get-settings
      #
      # @return [Luadns::Schema::User] current user information.
      def me
        http_client.get(endpoint_url("/users/me")) do |response|
          parse_response(response, Schema::User)
        end
      end
    end
  end
end
