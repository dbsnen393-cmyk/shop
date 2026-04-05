require 'open-uri'

# Create test user if not exists
user = User.find_by(email: "user@example.com")
unless user
  user = User.create!(
    name: "Random User",
    email: "user@example.com",
    password: "password",
    password_confirmation: "password"
  )
end

# Always reseed products
begin
  LineItem.destroy_all
  Product.destroy_all
rescue => e
  puts "Could not destroy: #{e.message}"
end

products = [
  {
    title: "Fossil Watch",
    brand: "Fossil",
    model: "FH256",
    description: "Classic men's watch with leather strap. Water resistant up to 50m. Perfect for everyday wear.",
    condition: "Mint",
    finish: "Black",
    price: "100",
    category: "Watches"
  },
  {
    title: "Opel Corsa",
    brand: "Opel",
    model: "Corsa 1.4",
    description: "Compact city car in excellent condition. Low mileage, full service history. Great fuel economy.",
    condition: "Excellent",
    finish: "Red",
    price: "15000",
    category: "Cars"
  },
  {
    title: "Ferrari F12",
    brand: "Ferrari",
    model: "F12 Berlinetta",
    description: "Stunning Italian sports car with 740hp V12 engine. 0-100 in 3.1 seconds. A true masterpiece.",
    condition: "New",
    finish: "Black",
    price: "160000",
    category: "Cars"
  },
  {
    title: "ThinkPad X1 Carbon",
    brand: "Lenovo",
    model: "ThinkPad X1 Carbon Touch",
    description: "Ultra-thin business laptop with 14-inch touch display, Intel Core i7, 16GB RAM, 512GB SSD.",
    condition: "Used",
    finish: "Black",
    price: "500",
    category: "Computers"
  },
  {
    title: "iPhone 15 Pro",
    brand: "Apple",
    model: "iPhone 15 Pro 256GB",
    description: "Latest Apple flagship with titanium design, A17 Pro chip, 48MP camera system.",
    condition: "New",
    finish: "Silver",
    price: "1200",
    category: "Phones"
  },
  {
    title: "Samsung Neo QLED TV",
    brand: "Samsung",
    model: "QN90C 55\"",
    description: "55 inch 4K Smart TV with Neo QLED quantum dot technology. HDR10+, 120Hz, Gaming Mode.",
    condition: "New",
    finish: "Black",
    price: "1500",
    category: "Electronics"
  }
]

products.each do |attrs|
  product = Product.new(attrs.merge(user: user))
  if product.save
    puts "Created: #{product.title}"
  else
    puts "Failed: #{attrs[:title]}: #{product.errors.full_messages.join(', ')}"
  end
end
