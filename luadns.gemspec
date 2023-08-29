lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "luadns/version"

Gem::Specification.new do |spec|
  spec.name = "luadns"
  spec.version = Luadns::VERSION
  spec.authors = ["Vitalie Cherpec"]
  spec.email = ["vitalie@penguin.ro"]
  spec.summary = "The LuaDNS API client for Ruby"
  spec.description = "The LuaDNS API client for Ruby."
  spec.homepage = "https://github.com/luadns/luadns-ruby"
  spec.license = "MIT"

  spec.required_ruby_version = ">= 2.7"

  spec.files = `git ls-files`.split($/)
  spec.executables = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.extra_rdoc_files = %w[LICENSE.txt]

  spec.add_dependency "httparty", "~> 0.21"

  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "minitest-reporters"
  spec.add_development_dependency "gem-release"
  spec.add_development_dependency "bump"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "yard"
end
