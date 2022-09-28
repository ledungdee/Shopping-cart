class CartItemsController < ApplicationController
  # before_action :create_cart_session, only: [:create]

  def index
      @cart_items = current_cart_items
      @cart_session = current_cart_session
    end 
  
  # def show
  #   @cart_item = CartItem.find(params[:id])
  # end

  def new
  end

  def create

      @cart_item = CartItem.new
      @cart_item.cart_session_id = current_user.cart_session.id
      @cart_item.quantity = params[:quantity]
      @cart_item.size = params[:size]
    
      @cart_item.product_id = current_product.id

      sum_money = @cart_item.cart_session.sum_money
      sum_money += @cart_item.product.price * @cart_item.quantity
      @cart_item.cart_session.update_attribute(:sum_money, sum_money)

      if @cart_item.save
          flash[:success] = 'Success added to cart'
          redirect_to current_product
      else
          render 'new', status: :unprocessable_entity
      end
    
  end

  def edit
  end

  def update
  end

  def destroy
    sum_money = current_cart_session.sum_money
    sum_money -= cart_item_destroy.product.price * cart_item_destroy.quantity
    current_cart_session.update_attribute(:sum_money, sum_money)
    cart_item_destroy.destroy
    flash[:success] = "Deleted this item"
    redirect_to cart_items_path, status: :see_other
  end

  def update_quantity

  end

  private
  def cart_item_params
    params.require(:cart_item).permit(:cart_session_id, :product_id, :quantity)
  end
end