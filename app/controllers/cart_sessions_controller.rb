class CartSessionsController < ApplicationController
  def index
    @cart_session = CartSession.all
  end

  def show
  end

  def new
    @cart_session = CartSession.new
  end

  def edit
  end

  def create
    @cart_session = CartSession.new
    @cart_session.user_id = session[:user_id]
    if @cart_session.save 
      flash[:success] = "Added to cart!"
    else 
      render 'new'
    end
  end

  def update
  end

  def destroy
  end

  def update_quantity
  end
end
