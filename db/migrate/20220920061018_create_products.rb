class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name
      t.references :shop
      t.string :color
      t.string :size
      t.string :price
      t.integer :quantity_remain, default:0
      t.string :description
      t.string :information
      
      t.timestamps
    end
  end
end
