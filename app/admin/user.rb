ActiveAdmin.register User do
	permit_params :device_token

	form do |f|
    f.inputs "User Details" do
      f.input :device_token
    end
    f.actions
  end
end
