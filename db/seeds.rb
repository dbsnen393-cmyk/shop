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
    category: "Watches",
    image_url: "https://images.unsplash.com/photo-1524592094714-0f0654e20314?w=800"
  },
  {
    title: "Opel Corsa",
    brand: "Opel",
    model: "Corsa 1.4",
    description: "Compact city car in excellent condition. Low mileage, full service history. Great fuel economy.",
    condition: "Excellent",
    finish: "Red",
    price: "15000",
    category: "Cars",
    image_url: "https://images.unsplash.com/photo-1552519507-da3b142c6e3d?w=800"
  },
  {
    title: "Ferrari F12",
    brand: "Ferrari",
    model: "F12 Berlinetta",
    description: "Stunning Italian sports car with 740hp V12 engine. 0-100 in 3.1 seconds. A true masterpiece.",
    condition: "New",
    finish: "Black",
    price: "160000",
    category: "Cars",
    image_url: "https://images.unsplash.com/photo-1583121274602-3e2820c69888?w=800"
  },
  {
    title: "ThinkPad X1 Carbon",
    brand: "Lenovo",
    model: "ThinkPad X1 Carbon Touch",
    description: "Ultra-thin business laptop with 14-inch touch display, Intel Core i7, 16GB RAM, 512GB SSD.",
    condition: "Used",
    finish: "Black",
    price: "500",
    category: "Computers",
    image_url: "https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=800"
  },
  {
    title: "iPhone 15 Pro",
    brand: "Apple",
    model: "iPhone 15 Pro 256GB",
    description: "Latest Apple flagship with titanium design, A17 Pro chip, 48MP camera system.",
    condition: "New",
    finish: "Silver",
    price: "1200",
    category: "Phones",
    image_url: "https://images.unsplash.com/photo-1510557880182-3d4d3cba35a5?w=800"
  },
  {
    title: "Samsung Neo QLED TV",
    brand: "Samsung",
    model: "QN90C 55\"",
    description: "55 inch 4K Smart TV with Neo QLED quantum dot technology. HDR10+, 120Hz, Gaming Mode.",
    condition: "New",
    finish: "Black",
    price: "1500",
    category: "Electronics",
    image_url: "https://images.unsplash.com/photo-1593784991095-a205069470b6?w=800"
  }
]

products.each do |attrs|
  image_url = attrs.delete(:image_url)

  # First save without image (guaranteed to work)
  product = Product.new(attrs.merge(user: user))
  if product.save
    puts "Created: #{product.title}"

    # Then try to attach image separately
    begin
      product.remote_image_url = image_url
      if product.save
        puts "  Image uploaded for: #{product.title}"
      else
        puts "  Image failed for #{product.title}: #{product.errors.full_messages.join(', ')}"
      end
    rescue => e
      puts "  Could not upload image for #{product.title}: #{e.message}"
    end
  else
    puts "Failed to save #{attrs[:title]}: #{product.errors.full_messages.join(', ')}"
  end
end
