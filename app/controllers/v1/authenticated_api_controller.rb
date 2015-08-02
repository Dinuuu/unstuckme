module V1
	class AuthenticatedApiController < ApplicationController
    before_action :check_user_creation

    def check_user_creation
      user_device = request.headers['TOKEN']
      @user = User.find_or_create_by(device_token: user_device) if user_device.present?
    end
	end
end
