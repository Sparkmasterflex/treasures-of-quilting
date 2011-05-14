require File.expand_path('../boot', __FILE__)

require 'rails/all'

# If you have a Gemfile, require the gems listed there, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env) if defined?(Bundler)

module Toq
  class Application < Rails::Application

    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.after_initialize do
      Dir.glob(File.join(File.expand_path(Rails.root), "lib", "extensions", "*.rb")).each do |processor|
        require processor
      end
      require 'ability'
    end

    config.filter_parameters += [:password]
  end
end
