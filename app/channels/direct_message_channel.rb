class DirectMessageChannel < ApplicationCable::Channel
  def subscribed
    if user_has_permission?
      stream_from "chat_#{params[:chatroom_id]}"
    end
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end


  private
  def user_has_permission?

  end
end
