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
  def checkout
    @order = Order.new
    @order.user_id = current_cart_session.user_id
    @order.sum_money = current_cart_session.sum_money
    if  @order.save 
      current_cart_session.cart_items.each do |cart_item|
        OrderItem.create(newAtrs(@order, cart_item))
        # quantity remove
        decrease_product_quantity(cart_item)
        cart_item.destroy
      end
      current_cart_session.update_attribute(:sum_money,0)
      flash[:success] = "Order successfully"
      redirect_to root_path
    else 
      flash[:danger] = "Order fail"  
    end
  end

  private
  def decrease_product_quantity(cart_item)
    if cart_item.size == "S"
      before = cart_item.product.size_s
      after = before - cart_item.quantity
      cart_item.product.update_attribute(:size_s,after)
    elsif cart_item.size == "M"
      before = cart_item.product.size_m
      after = before - cart_item.quantity
      cart_item.product.update_attribute(:size_m,after) 
    elsif cart_item.size == "L"
      before = cart_item.product.size_l
      after = before - cart_item.quantity
      cart_item.product.update_attribute(:size_l,after)
    elsif cart_item.size == "XL"
      before = cart_item.product.size_xl
      after = before - cart_item.quantity
      cart_item.product.update_attribute(:size_xl,after)
    end  
  end
  def newAtrs(order, cart_item)
    {
      order_id: order.id,
      product_id: cart_item.product_id,
      quantity: cart_item.quantity,
      size: cart_item.size
    }
  end
end
