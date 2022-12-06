# frozen_string_literal: true

class CartSessionsController < ApplicationController
  # before_action :check_quantity only:[:checkout]

  def show
    @cart_items = current_cart_session.cart_items
    @item_number = 0
    @cart_items.each do |t|
      @item_number += t.quantity
    end
  end

  def checkout
    @cart_items = current_cart_session.cart_items
    if !@cart_items.blank?
      check = true
      cart_items = current_cart_session.cart_items
      (0...cart_items.length).each do |i|
        total = cart_items[i].quantity
        (i + 1...cart_items.length).each do |j|
          if cart_items[i].size == cart_items[j].size && cart_items[i].product_id == cart_items[j].product_id
            total += cart_items[j].quantity
          end
        end
        @id = cart_items[i].product_id
        @s = cart_items[i].size
        t = max_quantity(@id, @s)
        check = false if total > t
      end
      if check == false
        flash[:danger] = 'Over the quantity'
        redirect_to cart_items_path
      else
        @order = Order.new
        @order.user_id = current_cart_session.user_id
        @order.phone = current_user.delivery_number
        @order.address = current_user.delivery_address
        @order.name = current_user.delivery_name
        sum_money = current_cart_session.sum_money
        sum_money += $ship
        @order.sum_money = current_cart_session.sum_money
        if @order.save
          current_cart_session.cart_items.each do |cart_item|
            OrderItem.create(newAtrs(@order, cart_item))
            # quantity remove
            decrease_product_quantity(cart_item)
            cart_item.destroy
          end
          current_cart_session.update_attribute(:sum_money, 0)
          flash[:success] = 'Order successfully'
          redirect_to orders_path
        else
          flash[:danger] = 'Error'
        end
      end
    else
      flash[:danger] = 'The no item in cart or the item was removed'
      redirect_to cart_items_path
    end
  end

  private

  def decrease_product_quantity(x)
    case x.size
    when 'S'
      before = x.product.size_s
      after = before - x.quantity
      x.product.update_attribute(:size_s, after)
    when 'M'
      before = x.product.size_m
      after = before - x.quantity
      x.product.update_attribute(:size_m, after)
    when 'L'
      before = x.product.size_l
      after = before - x.quantity
      x.product.update_attribute(:size_l, after)
    else
      before = x.product.size_xl
      after = before - x.quantity
      x.product.update_attribute(:size_xl, after)
    end
  end

  def newAtrs(order, cart_item)
    @product = Product.find_by(id: cart_item.product_id)
    @shop = @product.shop
    {
      order_id: order.id,
      product_id: cart_item.product_id,
      quantity: cart_item.quantity,
      size: cart_item.size,
      price: cart_item.product.price,
      name: cart_item.product.name,
      shop_id: @shop.id
    }
  end

  def max_quantity(id, size)
    @product = Product.find_by(id:)
    case size
    when 'S' then @product.size_s
    when 'M' then @product.size_m
    when 'L' then @product.size_l
    else
      @product.size_xl
    end
  end
end
