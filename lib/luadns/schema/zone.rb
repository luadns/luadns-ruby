# frozen_string_literal: true

module Luadns
  module Schema
    class Zone < Base
      attr_accessor :id
      attr_accessor :name
      attr_accessor :created_at
      attr_accessor :updated_at
    end
  end
end
