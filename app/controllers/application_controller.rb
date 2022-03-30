class ApplicationController < ActionController::Base
  include Clearance::Controller
  before_action :require_login

  rescue_from CanCan::AccessDenied do |exception|
    @error_message = exception.message
      redirect_to root_path, :notice=> @error_message.to_s
  end
end
