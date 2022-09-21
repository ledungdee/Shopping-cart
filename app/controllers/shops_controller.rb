class ShopsController < ApplicationController
  def new
    @shop = current_user.build_shop 
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
  def edit
    @shop = Shop.find(params[:id])
  end
  def update
    @shop = Shop.find(params[:id])
    if @shop.update(shop_params)
      # Handle a successful update.
      flash[:success] = "Shop updated!"
      redirect_to @shop 
    end
  end
  def show
    @shop = Shop.find(params[:id])
  end
  def destroy
  end 
  private
    def shop_params
      params.require(:shop).permit(:name, :description)
    end


end
