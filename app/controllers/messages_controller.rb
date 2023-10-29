class MessagesController < ApplicationController
  before_action :require_user, only: [:create]

  def create
    @message = Message.new(params.require(:message).permit(:body))
    @message.user = current_user
    if @message.save
      # redirect_to root_path
      ActionCable.server.broadcast "chatroom_channel", {mod_message: message_render(@message)}
    end
  end

  def message_render(message)
    render(partial: 'message', locals: {message: message})
  end
end
