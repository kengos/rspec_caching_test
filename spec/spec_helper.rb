# coding: utf-8
require 'tzinfo'
require 'action_controller/railtie'

module RspecCachingApplication
  class Application < Rails::Application
    config.active_support.deprecation = :notify
  end
end
RspecCachingApplication::Application.initialize!

require 'rspec'
require 'rspec/rails'

require File.expand_path(File.dirname(__FILE__) + '/../lib/rspec_caching_test')

RSpec.configure do |config|
  config.mock_with :rspec
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.filter_run focus: true
  config.run_all_when_everything_filtered = true

  config.before(:each) do
    ::RspecCachingTest::setup
  end
end