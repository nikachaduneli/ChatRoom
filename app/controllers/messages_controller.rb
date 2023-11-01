class MessagesController < ApplicationController
  before_action :require_user, only: [:create]

  def create
    @message = Message.new(params.require(:message).permit(:body))
    @message.user = current_user
    if @message.save
      ActionCable.server.broadcast "chatroom_channel", {message_body: message_render(@message)}
    end
  end

  def message_render(message)
    render(partial: 'message', locals: {message: message})
  end
end
