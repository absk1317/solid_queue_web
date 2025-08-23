module SolidQueueWeb
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      source_root File.expand_path("templates", __dir__)

      def create_initializer
        template "initializer.rb", "config/initializers/solid_queue_web.rb"
      end

      def add_routes
        route 'mount SolidQueueWeb::Engine => "/solid_queue"'
      end

      def show_instructions
        say ""
        say "SolidQueueWeb has been installed!", :green
        say ""
        say "You can now:"
        say "  1. Configure authentication in config/initializers/solid_queue_web.rb"
        say "  2. Visit http://localhost:3000/solid_queue to view the dashboard"
        say ""
      end
    end
  end
end