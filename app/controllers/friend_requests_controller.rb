
class FriendRequestsController < ApplicationController
  include  FriendRequestsHelper
  before_action :set_request, only: [:destroy, :update]

  def index
    @requests = current_user.received_requests
  end

  def create
    @request = FriendRequest.new(request_params)
    if @request.valid? && !@request.receiver.friends_with(@request.sender.id)
      @request.save!
    end
    redirect_to users_path
  end

  def destroy
    @request.status = RequestStates::DECLINED
    @request.save!
    @request.receiver.friends.delete @request.sender
    redirect_to friend_requests_path
  end

  def update
    @request.sender.friends << @request.receiver
    @request.receiver.friends << @request.sender
    @request.status = RequestStates::ACCEPTED
    @request.save!

    chat = Chat.new(user_1: @request.sender, user_2: @request.receiver)
    if chat.save
      flash[:notice] = "#{@request.sender.username} has been added to your friends"
      redirect_to friend_requests_path
    else
      redirect_to friend_requests_path, status: :unprocessable_entity
    end
  end
  def request_params
    params[:request][:status] = RequestStates::PENDING
    params.require(:request).permit(:sender_id, :user_id, :status)
  end

  def set_request
    @request= FriendRequest.find(params[:id])
  end
end
