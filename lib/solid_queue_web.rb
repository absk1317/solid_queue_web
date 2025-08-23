require "solid_queue_web/version"
require "solid_queue_web/engine"

module SolidQueueWeb
  class << self
    attr_accessor :http_basic_auth_username, :http_basic_auth_password
    attr_accessor :jobs_per_page

    def configure
      yield self
    end

    def jobs_per_page
      @jobs_per_page ||= 25
    end

    def auth_enabled?
      http_basic_auth_username.present? && http_basic_auth_password.present?
    end
  end
end