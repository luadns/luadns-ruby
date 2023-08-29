# frozen_string_literal: true

module Luadns
  module Schema
    class Base
      def initialize(options = {})
        options.each do |name, value|
          send("#{name}=", value)
        end
      end

      def []=(name, value)
        send("#{name}=", value) if respond_to?(name)
      end
    end
  end
end
