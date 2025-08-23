require_relative "lib/solid_queue_web/version"

Gem::Specification.new do |spec|
  spec.name        = "solid_queue_web"
  spec.version     = SolidQueueWeb::VERSION
  spec.authors     = ["Abhishek Verma"]
  spec.email       = ["absk1322@gmail.com"]
  spec.homepage    = "https://github.com/absk1317/solid_queue_web"
  spec.summary     = "A clean web interface for monitoring Solid Queue jobs"
  spec.description = "Provides a beautiful, easy-to-integrate web dashboard for monitoring Solid Queue background jobs with filtering, statistics, and job management capabilities."
  spec.license     = "MIT"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/main/CHANGELOG.md"

  spec.files = Dir["{app,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", ">= 7.0.0"
  spec.add_dependency "solid_queue", ">= 0.1.0"

  spec.add_development_dependency "sqlite3"
  spec.add_development_dependency "rspec-rails"
  spec.add_development_dependency "factory_bot_rails"

  spec.required_ruby_version = ">= 3.1.0"
end