
class FriendRequestsController < ApplicationController
  include  FriendRequestsHelper
  before_action :set_request, only: [:destroy, :update]

  def index
    @requests = current_user.received_requests
  end

  def create
    @request = FriendRequest.new(request_params)
    unless @request.already_exists? or @request.receiver.friends_with(@request.sender.id)
      @request.save!
    end
    # end
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
    redirect_to friend_requests_path
  end
  def request_params
    params[:request][:status] = RequestStates::PENDING
    params.require(:request).permit(:sender_id, :user_id, :status)
  end

  def set_request
    @request= FriendRequest.find(params[:id])
  end
end
