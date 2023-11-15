class FriendRequest < ApplicationRecord
  belongs_to :receiver, class_name: "User", foreign_key: :user_id
  belongs_to :sender, class_name: "User", foreign_key: :sender_id
  validate :users_not_equal
  validate :not_already_exists

  def not_already_exists
    if self.class.where(sender_id: self.sender.id, user_id: self.receiver.id, status: self.status).exists?
      errors.add(:receiver, 'request already exists')
    end
  end

  def users_not_equal
    if sender == receiver
      errors.add(:user_2, 'cant be equal to user_1')
    end
  end
end


