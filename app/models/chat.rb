class Chat < ApplicationRecord
  has_many :direct_messages
  belongs_to :user_1, class_name: 'User', foreign_key: :user_1_id
  belongs_to :user_2, class_name: 'User', foreign_key: :user_2_id

  validate :users_not_equal
  def users_not_equal
    if user_1 == user_2
      errors.add(:user_2, 'cant be equal to user_1')
    end
  end
end
