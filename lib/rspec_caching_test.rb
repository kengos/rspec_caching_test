# coding: utf-8

require "rspec_caching_test/version"
require "rspec_caching_test/test_store"
require "rspec_caching_test/machers"

module RspecCachingTest
  class << self
    def setup(do_read_cache = false)
      Rails.configuration.action_controller.perform_caching = true
      Rails.configuration.action_controller.cache_store = ::RspecCachingTest::TestStore.new(do_read_cache)
      RSpec::Matchers.class_eval do
        include ::RSpecCachingTest::Matchers
      end
    end
  end
end