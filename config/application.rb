require_relative "boot"

require "rails/all"
# require "rails"
# # Pick the frameworks you want:
# require "active_model/railtie"
# require "active_job/railtie"
# require "active_record/railtie"
# # require "active_storage/engine"
# require "action_controller/railtie"
# require "action_mailer/railtie"
# require "action_mailbox/engine"
# require "action_text/engine"
# require "action_view/railtie"
# require "action_cable/engine"
# require "sprockets/railtie"
# # require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module BernUmdze
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    # config.load_defaults 6.0
    config.load_defaults 7.0

    # config.autoloader = :zeitwerk

    config.time_zone = "Zurich"
    # hoping to ignore timezones and just display time entered
    # https://makandracards.com/makandra/46009-working-with-or-without-time-zones-in-rails-applications
    config.active_record.default_timezone = :local
    config.active_record.time_zone_aware_attributes = false

    # # Settings in config/environments/* take precedence over those specified here.
    # # Application configuration can go into files in config/initializers
    # # -- all .rb files in that directory are automatically loaded after loading
    # # the framework and any gems in your application.

    # # Don't generate system test files.
    config.generators.system_tests = nil

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("spec","mailers","previews")
  end
end
