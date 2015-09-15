require "application_responder"

class ApplicationController < ActionController::Base
  before_filter :set_default_request_format
  self.responder = ApplicationResponder
  respond_to :json

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  private

  def attribute
    querystring = URI.parse(request.env['ORIGINAL_FULLPATH']).query
    CGI.parse(querystring).first.first.to_sym
  end

  def set_default_request_format
    request.format = :json
  end
end
