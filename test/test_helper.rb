# frozen_string_literal: true

require "luadns"
require "minitest/autorun"
require "minitest/reporters"
require "webmock/minitest"
require "support/helpers"

Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(color: true)]

module Luadns
  class Test < Minitest::Test
    # For `it` helper which makes tests more readable.
    extend Minitest::Spec::DSL

    include MinitestHelpers
  end
end
