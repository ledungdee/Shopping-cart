# frozen_string_literal: true

class ProductsController < ApplicationController
  before_action :logged_in_user, only: %i[edit update destroy]
  before_action :correct_shop_product, only: %i[edit update destroy]
  before_action :check_not_exist, only: %i[show edit]

  # edit product: only by current shop
  def new
    @product = current_shop.products.build
  end

  def create
    @product = Product.new(product_params)
    @product.shop_id = current_shop.id
    if @product.save
      flash[:success] = 'Add sucessful '
      redirect_to @product
    else
      render 'new', status: :unprocessable_entity
    end
  end
  #     def create
  #         if params[:product][:size_M] =='1'
  #             @product = current_shop.products.build(product_params)
  #             @quantity = params[:product][:Quantity_M]
  #             if  @product.save
  #                 @product.update(size: "M", quantity_remain: @quantity)
  #                 @x = 1
  #             end
  #        end

  #        if params[:product][:size_L] =='1'
  #             @product = current_shop.products.build(product_params)
  #             @quantity = params[:product][:Quantity_L]
  #             if  @product.save
  #                 @product.update(size: "L", quantity_remain: @quantity)
  #                 @y = 1
  #             end
  #         end

  #         if params[:product][:size_XL] =='1'
  #             @product = current_shop.products.build(product_params)
  #             @quantity = params[:product][:Quantity_XL]
  #             if  @product.save
  #                 @product.update(size: "XL", quantity_remain: @quantity)
  #                 @z = 1
  #             end
  #        end
  #        if @x == 1 || @y== 1 || @z ==1
  #             flash[:success] = "Success!"
  #             redirect_to root_url
  #         else
  #             render 'new', status: :unprocessable_entity
  #         end
  #    end

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
    @shop = @product.shop
    $id_current_product = @product.id
    @count = sold_count
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      @cart_items = CartItem.where(product_id: @product.id)
      @cart_items.each do |cart_item|
        @cart_session = cart_item.cart_session
        sum_money = @cart_session.sum_money
        sum_money += (@product.price - cart_item.price) * cart_item.quantity
        @cart_session.update_attribute(:sum_money, sum_money)
        cart_item.update_attribute(:price, @product.price)
      end
      flash[:success] = 'Updated sucessful!'
      redirect_to @product
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @cart_items = CartItem.where(product_id: params[:id])
    @cart_items.each do |cart_item|
      @cart_session = cart_item.cart_session
      sum_money = @cart_session.sum_money
      sum_money -= cart_item.quantity * @product.price
      @cart_session.update_attribute(:sum_money, sum_money)
      cart_item.destroy
    end
    @product.destroy
    flash[:success] = 'Sucscess deleted item'
    redirect_to current_shop, status: :see_other
  end

  private

  def product_params
    params.require(:product).permit(:shop_id, :name, :color, :price, :size_s, :size_m, :size_l, :size_xl,
                                    :description, :information, images: [])
  end

  def logged_in_user
    return unless logged_in? == false

    # store_location #L10.32
    flash[:danger] = 'Please log in.'
    redirect_to login_url, status: :see_other
  end

  def correct_shop_product
    @shop = current_shop
    @product = Product.find_by(id: params[:id])
    return unless current_shop.id != @product.shop_id

    flash[:danger] = 'Access denied!'
    redirect_to root_url, status: :see_other
  end

  def check_not_exist
    @product = Product.find_by(id: params[:id])
    return unless @product.blank?

    redirect_to root_path
    flash[:danger] = 'Product not exist!'
  end

  def sold_count
    @order_items = OrderItem.where(product_id: @product.id)
    return 0 if @order_items.blank?

    @order_items.each do |order_item|
      @count = 0
      @count += order_item.quantity
    end
    @count
  end
end
