# frozen_string_literal: true

class Product < ApplicationRecord
  belongs_to :shop

  validates :name,  presence: true, length: { maximum: 50 }
  validates :price, presence: true
  validates_numericality_of :price, greater_than: 0
  validates :color, presence: true
  validates :images, presence: true
  mount_uploaders :images, ImageUploader
end
