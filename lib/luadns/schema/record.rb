# frozen_string_literal: true

module Luadns
  module Schema
    class Record < Base
      attr_accessor :id
      attr_accessor :name
      attr_accessor :type
      attr_accessor :content
      attr_accessor :ttl
      attr_accessor :zone_id
      attr_accessor :created_at
      attr_accessor :updated_at
    end
  end
end
