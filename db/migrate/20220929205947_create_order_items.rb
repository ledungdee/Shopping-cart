# frozen_string_literal: true

class CreateOrderItems < ActiveRecord::Migration[7.0]
  def change
    create_table :order_items do |t|
      t.references :order
      t.integer :product_id
      t.integer :quantity
      t.string  :size
      t.integer :price
      t.string :name
      t.integer :shop_id

      t.timestamps
    end
  end
end
