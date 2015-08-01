class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private

  def record_not_found
  	render status: :not_found, json: {}
  end
end
