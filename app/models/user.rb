class User < ActiveRecord::Base
	validates :device_token, presence: true, uniqueness: true
end
