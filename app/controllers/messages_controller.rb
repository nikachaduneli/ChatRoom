class MessagesController < ApplicationController
  before_action :require_user, only: [:create]

  def create
    @message = Message.new(params.require(:message).permit(:body))
    @message.sender = current_user
    if @message.save
      ActionCable.server.broadcast "chatroom_channel", {message_body: message_render(@message)}
    else
      render json: { errors: @direct_message.errors.full_messages }, status: :unprocessable_entity
    end

  end

  def message_render(message)
    render(partial: 'message', locals: {message: message})
  end
end
