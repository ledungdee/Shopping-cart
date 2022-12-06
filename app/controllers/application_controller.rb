# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include SessionsHelper
  include ShopsHelper
  include ProductsHelper
  include CartSessionsHelper
  include CartItemsHelper
end
