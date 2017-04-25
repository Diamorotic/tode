class User < ApplicationRecord
	has_many :lists
	has_secure_password
	validates :name, presence: true, length: { minimum: 2 }
end
