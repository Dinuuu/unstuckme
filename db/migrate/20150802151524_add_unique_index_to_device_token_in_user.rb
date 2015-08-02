class AddUniqueIndexToDeviceTokenInUser < ActiveRecord::Migration
  def change
  	add_index :users, :device_token, unique: true
  end
end
