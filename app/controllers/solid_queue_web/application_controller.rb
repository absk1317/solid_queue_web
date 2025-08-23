module SolidQueueWeb
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    
    before_action :authenticate_user!
    
    private
    
    def authenticate_user!
      return unless SolidQueueWeb.auth_enabled?
      
      authenticate_or_request_with_http_basic do |username, password|
        username == SolidQueueWeb.http_basic_auth_username &&
          password == SolidQueueWeb.http_basic_auth_password
      end
    end
  end
end