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

# Seed products if none exist
if Product.count == 0
  products = [
    {
      title: "Watch",
      brand: "Fossil",
      model: "FH256",
      description: "Good watch for men!",
      condition: "Mint",
      finish: "Black",
      price: "100",
      image_path: "app/assets/images/fossil.jpg"
    },
    {
      title: "Car",
      brand: "Opel",
      model: "Corsa",
      description: "Cool red car",
      condition: "Excellent",
      finish: "Red",
      price: "15000",
      image_path: "app/assets/images/opel.jpeg"
    },
    {
      title: "Car",
      brand: "Ferrari",
      model: "F12",
      description: "Cool sports car",
      condition: "New",
      finish: "Black",
      price: "160000",
      image_path: "app/assets/images/ferrari.jpeg"
    },
    {
      title: "Computer",
      brand: "Lenovo",
      model: "ThinkPad X1 Carbon Touch",
      description: "The Lenovo ThinkPad X1 Carbon Touch is an incredibly thin and light business ultrabook.",
      condition: "Used",
      finish: "Black",
      price: "500",
      image_path: "app/assets/images/computer.jpg"
    }
  ]

  products.each do |attrs|
    image_path = attrs.delete(:image_path)
    product = Product.new(attrs.merge(user: user))
    full_path = Rails.root.join(image_path)
    product.image = File.open(full_path) if File.exist?(full_path)
    product.save!
  end
end
