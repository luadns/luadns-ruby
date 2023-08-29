module Luadns
  module Endpoint
    class Records < Base
      def initialize(http_client)
        super(http_client)
      end

      # Lists all zone records.
      #
      # @see http://www.luadns.com/api.html#list-records
      #
      # @return [Array<Luadns::Schema::Record>] all zone records.
      def list_records(zone)
        http_client.get(endpoint_url("/zones/#{zone.id}/records")) do |response|
          parse_response(response, Schema::Record)
        end
      end

      # Creates a zone record.
      #
      # @see http://www.luadns.com/api.html#create-a-record
      #
      # @param  [Luadns::Schema::Zone] zone the zone
      # @param  [Hash] attributes
      #
      # @return [Luadns::Schema::Record] created record.
      def create_record(zone, attributes)
        http_client.post(endpoint_url("/zones/#{zone.id}/records"), attributes) do |response|
          parse_response(response, Schema::Record)
        end
      end

      # Gets a zone record.
      #
      # @see http://www.luadns.com/api.html#get-a-record
      #
      # @param  [Luadns::Schema::Zone] zone the zone
      # @param  [Integer] record_id the record ID
      #
      # @return [Luadns::Schema::Record] requested zone.
      def get_record(zone, record_id)
        http_client.get(endpoint_url("/zones/#{zone.id}/records/#{record_id}")) do |response|
          parse_response(response, Schema::Record)
        end
      end

      # Updates a zone record.
      #
      # @see http://www.luadns.com/api.html#update-a-record
      #
      # @param  [Luadns::Schema::Zone] zone the zone
      # @param  [Integer] record_id the record ID
      # @param  [Hash] attributes
      #
      # @return [Luadns::Schema::Record] updated zone.
      def update_record(zone, record_id, attributes)
        http_client.put(endpoint_url("/zones/#{zone.id}/records/#{record_id}"), attributes) do |response|
          parse_response(response, Schema::Record)
        end
      end

      # Deletes a zone record.
      #
      # @see http://www.luadns.com/api.html#delete-a-record
      #
      # @param  [Luadns::Schema::Zone] zone the zone
      # @param  [Integer] record_id the record ID
      #
      # @return [Luadns::Schema::Record] deleted zone.
      def delete_record(zone, record_id)
        http_client.delete(endpoint_url("/zones/#{zone.id}/records/#{record_id}")) do |response|
          parse_response(response, Schema::Record)
        end
      end
    end
  end
end
