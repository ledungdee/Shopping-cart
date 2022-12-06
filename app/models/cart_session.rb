# frozen_string_literal: true

class CartSession < ApplicationRecord
  belongs_to :user
  has_many :cart_items
end
