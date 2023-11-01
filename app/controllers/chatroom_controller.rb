class ChatroomController < ApplicationController
  def index
    @messages = Message.last 40
  end
end
