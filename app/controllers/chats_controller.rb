class ChatsController < ApplicationController
  before_action :require_user, only: [:index, :show]

  def index
    @messages = Message.last 40
  end

  def chat_ids
    render json: { chatroom_ids: Chat.pluck(:id)}
  end

  def show
    @chat = Chat.find(params[:chat_id])
    @messages = @chat.direct_messages
    @friend_id = @chat.user_1 == current_user ? @chat.user_2_id : @chat.user_1_id
  end
end
