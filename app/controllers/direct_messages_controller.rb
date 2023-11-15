class DirectMessagesController < ApplicationController

  def create
    @direct_message = DirectMessage.new(direct_message_params)

    if @direct_message.save
      message_html = message_render(@direct_message)
      ActionCable.server.broadcast "chat_#{direct_message_params[:chat_id]}", {message_body: message_html}
    else
      render json: { errors: @direct_message.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def message_render(message)
    render_to_string(partial: 'message', locals: { message: message})
  end

  def direct_message_params
      params.require(:direct_message).permit(:sender_id, :receiver_id, :body, :chat_id)
  end
end
