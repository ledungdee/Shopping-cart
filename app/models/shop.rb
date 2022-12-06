# frozen_string_literal: true

class Shop < ApplicationRecord
  belongs_to :user
  has_many :products

  # has_one_attached :image
  mount_uploader :avatar, ImageUploader

  validates :user_id, presence: true
  validates :name, presence: true, length: { maximum: 50 }, uniqueness: true
end
