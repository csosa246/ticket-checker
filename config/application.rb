require_relative 'boot'
require 'rails/all'

Bundler.require(*Rails.groups)

module ViolationScanner
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    config.active_record.schema_format = :sql
    config.active_job.queue_adapter = :sidekiq

    config.action_dispatch.rescue_responses['Pundit::NotAuthorizedError'] = :not_found
    config.eager_load_paths << Rails.root.join('lib')

    config.paperclip_defaults = {
      storage: :s3,
      bucket: ENV['S3_BUCKET'],
      s3_credentials: {
        s3_credentials: {
          access_key_id: ENV['AWS_ACCESS_KEY'],
          secret_access_key: ENV['AWS_SECRET_KEY']
        }
      },
      s3_protocol: 'https',
      s3_region: 'us-east-1',
      s3_permissions: :private
    }

    ENV['FIXTURES_PATH'] = 'spec/fixtures'
  end
end

