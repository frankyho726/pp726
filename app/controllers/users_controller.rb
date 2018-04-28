class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy] #10.58 update destory #10.15 do
  before_action :correct_user,   only: [:edit, :update] #10.25 do
  before_action :admin_user,     only: :destroy  #10.59 do
  
  def index  #10.35 do
    @users = User.where(activated: true).paginate(page: params[:page])#10.36 do >>10.46 >>ex 11.40
  end
  
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
 #   redirect_to root_url and return unless (@user.activated) #11.40 ex
 #   debugger
    
  end

  def new
   @user = User.new
  end
  
  def create
    @user = User.new(user_params)  
    if @user.save
#      log_in @user  #change in 11.23
       @user.send_activation_email
       flash[:info] = "Please check your email to activate your account."
       redirect_to root_url
      
#      flash[:success] = "Welcome to the Sample App!"  #change in 11.23
#      redirect_to @user #change in 11.23
    else
      render 'new'
    end
  end
  
  def edit  
                   # 10.25 do    @user = User.find(params[:id])
  end
  
  
  #10.12 do
  def update
                  #10.25 do    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  #10.58 do
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  
  
  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
     # debugger
    end
    # Before filters
    
     # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
#10.59 do    
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
