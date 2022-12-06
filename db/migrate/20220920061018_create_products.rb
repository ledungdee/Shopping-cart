# frozen_string_literal: true

class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name
      t.references :shop
      t.string :color
      t.integer :price
      t.integer :size_s, default: 0
      t.integer :size_m, default: 0
      t.integer :size_l, default: 0
      t.integer :size_xl, default: 0
      t.string :description
      t.string :information
      t.json :images

      t.timestamps
    end
  end
end
