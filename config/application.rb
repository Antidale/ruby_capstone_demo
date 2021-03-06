require File.expand_path('../boot', __FILE__)

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RubyCapstoneDemo
  class Application < Rails::Application

    # set up CORS, replace 'siteB.com' with your actual allowed site
    config.middleware.insert_before 0, "Rack::Cors" do
      allow do
        origins 'siteB.com'
        resource '/api/*',
          :headers => :any,
          :methods => [:get, :post, :put, :delete, :options]
      end
    end

    # Bootstrap mongoid config
    Mongoid.load!('./config/mongoid.yml')

    # Uncommented config.generators line will be the default
    config.generators { | g | g.orm :active_record}
    #config.generators { | g | g.orm :mongoid}

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true
  end
end
