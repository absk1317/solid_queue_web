require "rails/engine"

module SolidQueueWeb
  class Engine < ::Rails::Engine
    isolate_namespace SolidQueueWeb

    config.before_configuration do
      config.paths.add "app/controllers", eager_load: true
      config.paths.add "app/models", eager_load: true
      config.paths.add "app/helpers", eager_load: true
    end

    initializer "solid_queue_web.assets" do |app|
      app.config.assets.paths << root.join("app/assets/stylesheets")
    end
  end
end