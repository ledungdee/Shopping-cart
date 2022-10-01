class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :index, :destroy, :show]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user, only: [:destroy, :index]
  before_action :check_not_exist, only: [:show,:edit]
  def new
    @user = User.new 
  end
  def create
    @user = User.new(user_params)
    if @user.save
      reset_session
      log_in @user 
      create_cart_session
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
    @user = User.find_by(id:params[:id])
    @shop = @user.shop
  end

  def edit
    @user = User.find(params[:id])
    @shop = @user.shop
  end

  def update
    @user = User.find_by(id:params[:id])
    if @user.update(user_params)
      # Handle a successful update.
      @user.update_attribute(:delivery_address,@user.address)
      @user.update_attribute(:delivery_name,@user.name)
      @user.update_attribute(:delivery_number,@user.phone_number)
      flash[:success] = "Profile updated!"
      redirect_to @user 
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find_by(id:params[:id])
    if @user.shop.present?
      if @user.shop.products.present?
        @user.shop.products.destroy_all
      end
      @user.shop.destroy
    end
    @user.destroy
    flash[:success] = "User deleted"
    redirect_to users_url, status: :see_other
  end
  def change_delivery_address
    @user = current_user 
  end
  def update_delivery_address
    @user = current_user
    @user.update_attribute(:delivery_address, params[:user][:delivery_address])
    @user.update_attribute(:delivery_name, params[:user][:delivery_name])
    @user.update_attribute(:delivery_number, params[:user][:delivery_number])
    redirect_to cart_session_path(current_cart_session)
  end
  private
    def user_params 
      params.require(:user).permit(:name,:email,:password,:password_confirmation,:phone_number,:address,:delivery_address,:image,:image_cache) 
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
      @user = User.find_by(id:params[:id])
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
        flash[:danger] = 'Access denied'
      end
    end
    def check_not_exist
      @user = User.find_by(id:params[:id])
      if @user.blank?
        redirect_to root_path 
        flash[:danger] = "User not exist!"
      end
    end
    def create_cart_session
      if current_user.cart_session == nil
          @cart_session = CartSession.new
          @cart_session.user_id = current_user.id
          @cart_session.save
      end
    end
end


