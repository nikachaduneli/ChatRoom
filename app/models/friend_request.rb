class FriendRequest < ApplicationRecord
  belongs_to :receiver, class_name: "User", foreign_key: :user_id
  belongs_to :sender, class_name: "User", foreign_key: :sender_id

  def already_exists?
    self.class.where(sender_id: self.sender.id, user_id: self.receiver.id, status: self.status).exists?
  end
end


