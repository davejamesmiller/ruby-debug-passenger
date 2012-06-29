require "ruby-debug-passenger/version"
require "rails"

module RubyDebugPassenger
  class Railtie < Rails::Railtie

    # Initializer
    initializer "ruby-debug-passenger" do
      # When Passenger starts the app, this checks if debug.txt exists, and if
      # so it waits for the debugger to connect before continuing. It will only
      # ever run in the development environment (for safety more than anything
      # else).
      if Rails.env.development? && File.exists?(File.join(Rails.root, 'tmp', 'debug.txt'))
        begin
          require 'debugger'
        rescue LoadError
          begin
            require 'ruby-debug'
          rescue LoadError
            raise "One of the gems 'debugger' or 'ruby-debug' must be present when using the gem 'ruby-debug-passenger'"
          end
        end
        File.delete(File.join(Rails.root, 'tmp', 'debug.txt'))
        Debugger.wait_connection = true
        Debugger.start_remote
      end
    end

    # Rake task
    rake_tasks do
      load "tasks/debug.rake"
    end

  end
end
