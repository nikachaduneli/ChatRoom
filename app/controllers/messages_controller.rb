class MessagesController < ApplicationController
  before_action :require_user, only: [:create]

  def create
    @message = Message.new(params.require(:message).permit(:body))
    @message.user = current_user
    if @message.save
      redirect_to root_path
    end
  end
end
