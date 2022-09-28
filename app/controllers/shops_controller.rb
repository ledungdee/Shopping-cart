class ShopsController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :index, :destroy]
  before_action :correct_shop,   only: [:edit, :update, :destroy]
  before_action :check_not_exist, only: [:show,:edit]

  def new
    @shop = current_user.build_shop 
    @user = @shop.user 
  end
  def create
    @shop = current_user.build_shop(shop_params)
    if @shop.save
      current_user.update_attribute(:role, 1)
      flash[:success] = "Welcome to a new Shop!"
      redirect_to @shop 
    else
      render 'new', status: :unprocessable_entity
    end
  end
  def index
    @shops = Shop.all
  end
  def show
    @shop = Shop.find_by(id: params[:id])
    @products = @shop.products
  end

  def edit
    @shop = Shop.find(params[:id])
    @user = @shop.user 
  end
  def update
    @shop = Shop.find(params[:id])
    if @shop.update(shop_params)
      # Handle a successful update.
      flash[:success] = "Shop updated!"
      redirect_to @shop 
    end
  end
  def show_products
  @shop_products = current_shop.products
  end
  def destroy
    Shop.find_by(id:params[:id]).products.destroy_all
    Shop.find_by(id:params[:id]).destroy
    current_user.update_attribute(:role, 0)
    flash[:success] = "Shop deleted"
    redirect_to root_url, status: :see_other
  end 


  private
    def shop_params
      params.require(:shop).permit(:name, :description, :avatar)
    end
    def logged_in_user 
      if logged_in? == false 
          # store_location #L10.32
          flash[:danger] ="Please log in." 
          redirect_to login_url, status: :see_other 
      end 
    end
    def correct_shop 
      @shop = Shop.find_by(id:params[:id])
      # if @user != current_user
      if current_shop?(@shop) == false
        flash[:danger] ="Access denied!"
        redirect_to root_url, status: :see_other
      end
    end
    def check_not_exist
      @shop = Shop.find_by(id:params[:id])
      if @shop.blank?
        redirect_to root_url
        flash[:danger] = 'Shop not exist!'
      end
    end
end
