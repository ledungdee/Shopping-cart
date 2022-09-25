class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :index, :destroy, :show]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user, only: [:destroy]
  # before_action :not_exist, only: [:show,:edit]

  def new
    @user = User.new 
  end
def create
    @user = User.new(user_params)
    if @user.save
      reset_session
      log_in @user 
      flash[:success] ="Welcome to the Shopping Cart!"
      redirect_to @user
    else
      render 'new', status: :unprocessable_entity
    end
  end
  
  def index
    @users = User.all 
  end

  def show
    @user = User.find(params[:id])
    @shop = @user.shop
  end

  def edit
    @user = User.find(params[:id])
    @shop = @user.shop
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      # Handle a successful update.
      flash[:success] = "Profile updated!"
      redirect_to @user 
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url, status: :see_other
  end

  private
    def user_params 
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :phone_number, :address, :image ) 
    end  

    # Before filters
    # Confirms a logged-in user. 
    def logged_in_user 
      if logged_in? == false 
          store_location #L10.32
          flash[:danger] ="Please log in." 
          redirect_to login_url, status: :see_other 
      end 
    end

    def correct_user
      @user = User.find(params[:id])
      # if @user != current_user
      if current_user?(@user) == false
        flash[:danger] ="Access denied!"
        redirect_to root_url, status: :see_other
      end
    end

      # Confirms an admin user.
    def admin_user
      if !current_user.admin?
        redirect_to(root_url, status: :see_other)
      end
    end
    # def not_exist
    #   if !User.find(params[:id]).present?
    #     flash[:danger] = "Does not exist!"
    #     redirect_to root_url, status: :see_other 
    #   end
    # end

end


