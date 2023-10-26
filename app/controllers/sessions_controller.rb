class SessionsController < ApplicationController
  include SessionsHelper

  def create
    user = User.find_by(username: params[:session][:username].downcase)
    if user and user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:notice] = "Logged in Successfully"
      redirect_to root_path
    else
      flash.now[:alert] = "Incorrect email or Password"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:alert] = "Logged out"
    redirect_to root_path
  end
end
