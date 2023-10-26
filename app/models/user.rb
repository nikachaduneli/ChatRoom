class User < ApplicationRecord
  has_secure_password
  validates :username, presence: true, uniqueness: {case_sensitive: true}, length: {maximum: 20, minimum: 4}
end
