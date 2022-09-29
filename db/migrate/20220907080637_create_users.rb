class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :phone_number
      t.string :address
      t.string :delivery_address
      t.integer :admin, default:false 
      t.integer :role, default:0
      t.string :image 
    end
  end
end
