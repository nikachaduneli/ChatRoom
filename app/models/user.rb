class User < ApplicationRecord
  validates :username, presence: true, uniqueness: {case_sensitive: false}, length: {maximum: 20, minimum: 4}
  has_secure_password
  has_many :messages
end
