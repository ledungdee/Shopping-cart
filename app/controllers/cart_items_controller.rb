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
    
  end

  def update
  end

  def destroy
  end

  def update_quantity
  end
end
