class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def index
  end
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "User #{@user.username} was created successfully"
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end
  def search
    unless params[:search].blank?
      @parameter = params[:search].downcase
      @users = User.all.where('lower(username) like :search', search: "%#{@parameter}%")
      render :index
    end
  end


  private
  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end
end
