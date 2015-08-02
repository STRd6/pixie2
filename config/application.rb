require File.expand_path('../boot', __FILE__)

require 'rails/all'

require "sprockets/railtie"

require 'tilt/coffee'
require 'tilt/sass'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Pixie
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    config.autoload_paths << File.join(Rails.root, "lib")

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    config.assets.precompile += %w[screen.css]
    config.assets.enabled = true
    config.assets.initialize_on_precompile = false
    config.generators.stylesheet_engine = :sass

    config.middleware.use ExceptionNotification::Rack,
      :email => {
        :email_prefix => "[pixieengine.com] ",
        :sender_address => %{"Notifier" <notifier@pixieengine.com>},
        :exception_recipients => %w[yahivin@gmail.com]
      }
  end
end
