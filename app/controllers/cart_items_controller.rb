class CartItemsController < ApplicationController
  def index
    @cart_items = CartItem.all
    @cart_session = CartSession.first
  end

  def show
    @cart_item = CartItem.find(params[:id])
  end

  def new
  end

  def edit
  end

  def create
    @cart_item = CartItem.new
    @cart_item.quantity = params[:quantity]
    @cart_item.size = params[:size]
    @cart_item.cart_session_id = current_cart_session.id
    @cart_item.product_id = current_product.id
    
    sum_money = @cart_item.cart_session.sum_money
    sum_money += @cart_item.product.price.to_i * @cart_item.quantity
    current_cart_session.update_attribute(:sum_money, sum_money)

    if @cart_item.save 
        flash[:success] = 'Success added to cart'
        redirect_to current_product
    else
        render 'new', status: :unprocessable_entity
    end
  end

  def update
  end

  def destroy
  end

  def update_quantity
  end
end
