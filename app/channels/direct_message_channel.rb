class DirectMessageChannel < ApplicationCable::Channel
  def subscribed
    # chatroom = Chat.find(params[:chatroom_id])
    # if can_subscribe?(chatroom)
      stream_from "chat_#{params[:chatroom_id]}"
    # end

  end

  def can_subscribe?

  end
  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
