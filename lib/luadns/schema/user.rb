# frozen_string_literal: true

module Luadns
  module Schema
    class User < Base
      attr_accessor :email
      attr_accessor :name
      attr_accessor :repo_uri
      attr_accessor :api_enabled
      attr_accessor :tfa
      attr_accessor :deploy_key
      attr_accessor :ttl
      attr_accessor :package
      attr_accessor :name_servers
    end
  end
end
