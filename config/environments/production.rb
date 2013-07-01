RailsBestpracticesCom::Application.configure do
  # Settings specified here will take precedence over those in config/environment.rb

  # The production environment is meant for finished, "live" apps.
  # Code is not reloaded between requests
  config.cache_classes = true

  config.eager_load = true

  # Full error reports are disabled and caching is turned on
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # Specifies the header that your server uses for sending files
  # config.action_dispatch.x_sendfile_header = "X-Sendfile"

  # For nginx:
  config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect'

  # If you have no front-end server that supports something like X-Sendfile,
  # just comment this out and Rails will serve the files

  # See everything in the log (default is :info)
  # config.log_level = :debug

  # Use a different logger for distributed setups
  # config.logger = SyslogLogger.new

  # Use a different cache store in production
  # config.cache_store = ActiveSupport::Cache::MemCacheStore.new(Memcached::Rails.new("localhost:11211", :namespace => "railsbp", :logger => Rails.logger))

  # Disable Rails's static asset server
  # In production, Apache or nginx will already do this
  config.serve_static_assets = false

  # Compress JavaScripts and CSS
  config.assets.compress = true

  # Don't fallback to assets pipeline if a precompiled asset is missed
  config.assets.compile = false

  # Generate digests for assets URLs
  config.assets.digest = true

  # Enable serving of images, stylesheets, and javascripts from an asset server
  config.action_controller.asset_host = "http://assets.rails-bestpractices.com"

  # Disable delivery errors, bad email addresses will be ignored
  # config.action_mailer.raise_delivery_errors = false

  # Enable threaded mode
  # config.threadsafe!

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation can not be found)
  config.i18n.fallbacks = true

  config.active_support.deprecation = :notify

  config.active_record.observers = :notifier_observer, :vote_sweeper

  config.action_mailer.delivery_method = :smtp

  config.action_mailer.default_url_options = { :host => "rails-bestpractices.com" }

  config.middleware.use ExceptionNotifier,
    :email_prefix => "[rails-bestpractices.com] ",
    :sender_address => %{"Application Error" <exception.notifier@rails-bestpractices.com>},
    :exception_recipients => %w(flyerhzm@rails-bestpractices.com),
    :ignore_exceptions => %w(ActionView::MissingTemplate)

  config.after_initialize do
    if ContactUs.const_defined? :ContactMailer
      class ContactUs::ContactMailer
        mailer_account "notification"
      end
    end

    class ExceptionNotifier::Notifier
      mailer_account "exception.notifier"
    end
  end
end
