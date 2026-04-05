class Product < ApplicationRecord

  has_many :line_items, dependent: :destroy
  belongs_to :user, optional: true

  mount_uploader :image, ImageUploader
  serialize :image, JSON # If you use SQLite, add this line

  validates :title, :brand, :price, :model, presence: true
  # Set max lenght to the description, price and title 
  validates :description, length: { maximum: 1000, too_long: "%{count} characters is the maximum aloud. "}
  validates :title, length: { maximum: 140, too_long: "%{count} characters is the maximum aloud. "}
  validates :price, length: { maximum: 10 }

  BRAND = %w{ Apple BMW Dell Ferrari Ford HP Lenovo Mercedes Nike Opel Samsung Sony Toyota }
  FINISH = %w{ Black White Navy Blue Red Clear Satin Yellow Seafoam Green Silver Gold }
  CONDITION = %w{ New Excellent Mint Used Fair Poor }
  CATEGORY = %w{ Cars Clothes Computers Electronics Phones Watches Furniture Other }
end
