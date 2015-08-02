module V1
	class UsersController < AuthenticatedApiController
	  def show
      render status: :ok, json: @user
    end
  end
end