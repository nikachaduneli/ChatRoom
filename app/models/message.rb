class Message < ApplicationRecord
  validates :body, presence: true
  belongs_to :sender, class_name: 'User', foreign_key: :sender_id
end
