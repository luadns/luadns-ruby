# frozen_string_literal: true

module MinitestHelpers
  def read_http_fixture(filename)
    path = File.expand_path(File.expand_path("../../#{filename}", __dir__))
    File.binread(path)
  end
end
