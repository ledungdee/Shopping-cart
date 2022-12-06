# frozen_string_literal: true

class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.references :user
      t.references :product
      t.string :content
      t.string :images

      t.timestamps
    end
  end
end
