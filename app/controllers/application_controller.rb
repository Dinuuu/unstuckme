class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  rescue_from ActiveRecord::RecordNotUnique, with: :record_not_unique
  private

  def record_not_found
  	render status: :not_found, json: {}
  end

  def record_not_unique
  	render status: :precondition_failed, json: {}
  end
end
