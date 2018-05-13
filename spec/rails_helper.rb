ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)

# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?

require 'spec_helper'
require 'rspec/rails'
require 'sidekiq/testing'
require "paperclip/matchers"
require "pundit/rspec"

Dir[Rails.root.join('spec', 'support', '**', '*.rb')].each { |f| require f }

# Checks for pending migrations and applies them before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.infer_spec_type_from_file_location!

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = Rails.root.join('spec', 'fixtures').to_s
  config.global_fixtures = :all
  config.use_transactional_fixtures = true

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")

  config.include(Devise::Test::ControllerHelpers, type: :controller)
  config.include(Devise::Test::ControllerHelpers, type: :view)
  config.include(HandleExceptionsInSpecs, type: :controller)
  config.include(HelperMethodsInViews, type: :view)
  config.include Paperclip::Shoulda::Matchers

  config.before do
    Sidekiq::Worker.clear_all
    # Zlib.reset!
    Timecop.return_to_baseline
  end
end

