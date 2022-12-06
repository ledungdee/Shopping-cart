# frozen_string_literal: true

class CreateMicroposts < ActiveRecord::Migration[7.0]
  def change
    create_table :microposts do |t|
      t.string :content
      t.string :images

      t.timestamps
    end
  end
end
