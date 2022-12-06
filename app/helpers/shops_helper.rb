# frozen_string_literal: true

module ShopsHelper
  def current_shop
    @user = User.find_by(id: session[:user_id])
    return nil unless @user && @user.role == 1

    @user.shop
  end
end
