class CartSessionsController < ApplicationController
  def index
    @cart_session = CartSession.all
  end

  def show
    @cart_items = current_cart_session.cart_items
    @cart_session = current_cart_session
    @item_number = 0
    @cart_items.each do |t|
      @item_number += t.quantity
    end
  end
end
