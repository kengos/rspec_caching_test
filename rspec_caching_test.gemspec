# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "rspec_caching_test/version"

Gem::Specification.new do |s|
  s.name        = "rspec_caching_test"
  s.version     = RspecCachingTest::VERSION
  s.authors     = ["Kengo Suzuki"]
  s.homepage    = "https://github.com/kengos/rspec_caching_test"
  s.summary     = %q{RSpec caching test}
  s.description = %q{RSpec caching test helper}
  s.add_dependency "activesupport", '>= 3.0.0'
  s.add_dependency "rspec-rails", '>= 2.0.0'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_runtime_dependency "rest-client"
end
