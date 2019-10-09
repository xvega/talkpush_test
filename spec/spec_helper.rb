require 'rake'
require 'httparty'
require 'webmock/rspec'
require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/vcr_cassetes"
  config.hook_into :webmock
  config.configure_rspec_metadata!
  config.default_cassette_options = {
      match_requests_on: [:uri, :body, :method]
  }
  config.filter_sensitive_data('secret_api_key') { Rails.application.credentials.dig(:development, :talkpush, :api_key) }
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  config.shared_context_metadata_behavior = :apply_to_host_groups
end
