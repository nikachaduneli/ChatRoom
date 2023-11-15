class User < ApplicationRecord
  validates :username, presence: true, uniqueness: {case_sensitive: false}, length: {maximum: 20, minimum: 4}
  has_secure_password
  has_many :messages
  has_many :direct_messages
  has_many :chats

  has_many :friendships
  has_many :friends, through: :friendships

  has_many :sent_requests, class_name: "FriendRequest", foreign_key: 'sender_id'
  has_many :received_requests, class_name: "FriendRequest", foreign_key: 'user_id'

  def friends_with(id_of_friend)
    self.friends.where(id: id_of_friend).exists?
  end

  def chat_with(friend_id)
    chat = Chat.where('user_1_id = ? and user_2_id = ? or user_1_id = ? and user_2_id = ?', self.id, friend_id, friend_id, self.id)
    if chat.exists?
      chat.first
    end
  end
end
