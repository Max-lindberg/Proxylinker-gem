# frozen_string_literal: true

require_relative "lib/proxylinker/version"

Gem::Specification.new do |spec|
  spec.name = "proxylinker"
  spec.version = Proxylinker::VERSION
  spec.authors = ["Max Lindberg"]
  spec.email = ["xflickv1@gmail.com"]

  spec.summary = "A gem to manage proxies because other proxy gems didn't work for me."
  spec.description = "ProxyLinker allows you to load, validate, and use proxies from a list."
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"
  spec.homepage = "https://github.com/Max-lindberg/Proxylinker-gem"
  # Specify which files should be added to the gem when it is released.
  spec.files = Dir.glob("lib/**/*.rb") + ["proxylinker.gemspec", "README.md", "LICENSE.txt"]
  spec.require_paths = ["lib"]
end
