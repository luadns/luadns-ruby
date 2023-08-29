module Luadns
  module Endpoint
    class Zones < Base
      def initialize(http_client)
        super(http_client)
      end

      # Lists all zones.
      #
      # @see http://www.luadns.com/api.html#list-zones
      #
      # @return [Array<Luadns::Schema::Zone>] all user zones.
      def list_zones
        http_client.get(endpoint_url("/zones")) do |response|
          parse_response(response, Schema::Zone)
        end
      end

      # Creates a zone.
      #
      # @see http://www.luadns.com/api.html#create-a-zone
      #
      # @param  [Hash] attributes
      #
      # @return [Luadns::Schema::Zone] created zone.
      def create_zone(attributes)
        http_client.post(endpoint_url("/zones"), attributes) do |response|
          parse_response(response, Schema::Zone)
        end
      end

      # Gets a zone.
      #
      # @see http://www.luadns.com/api.html#get-a-zone
      #
      # @param  [Integer] zone_id the zone ID
      #
      # @return [Luadns::Schema::Zone] requested zone.
      def get_zone(zone_id)
        http_client.get(endpoint_url("/zones/#{zone_id}")) do |response|
          parse_response(response, Schema::Zone)
        end
      end

      # Updates a zone.
      #
      # @see http://www.luadns.com/api.html#update-a-zone
      #
      # @param  [Integer] zone_id the zone ID
      # @param  [Hash] attributes
      #
      # @return [Luadns::Schema::Zone] updated zone.
      def update_zone(zone_id, attributes)
        http_client.put(endpoint_url("/zones/#{zone_id}"), attributes) do |response|
          parse_response(response, Schema::Zone)
        end
      end

      # Deletes a zone.
      #
      # @see http://www.luadns.com/api.html#delete-a-zone
      #
      # @param  [Integer] zone_id the zone ID
      #
      # @return [Luadns::Schema::Zone] deleted zone.
      def delete_zone(zone_id)
        http_client.delete(endpoint_url("/zones/#{zone_id}")) do |response|
          parse_response(response, Schema::Zone)
        end
      end
    end
  end
end
