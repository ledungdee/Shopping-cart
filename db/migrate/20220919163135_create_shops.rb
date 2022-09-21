class CreateShops < ActiveRecord::Migration[7.0]
  def change
    create_table :shops do |t|
      t.string :name
      t.references :user
      t.string :description
      t.string :web_url
      t.string :avatar

      t.timestamps
    end
  end
end
