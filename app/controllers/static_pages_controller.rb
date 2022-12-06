# frozen_string_literal: true

class StaticPagesController < ApplicationController
  def home
    @products = Product.all
  end

  def help; end

  def contact; end

  def about; end

  def blog; end
end
