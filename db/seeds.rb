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
      description: "Good watch for men! Classic design, water resistant.",
      condition: "Mint",
      finish: "Black",
      price: "100",
      category: "Watches"
    },
    {
      title: "Opel Corsa",
      brand: "Opel",
      model: "Corsa",
      description: "Cool red car, low mileage, great condition.",
      condition: "Excellent",
      finish: "Red",
      price: "15000",
      category: "Cars"
    },
    {
      title: "Ferrari F12",
      brand: "Ferrari",
      model: "F12",
      description: "Cool sports car, incredible performance.",
      condition: "New",
      finish: "Black",
      price: "160000",
      category: "Cars"
    },
    {
      title: "ThinkPad X1 Carbon",
      brand: "Lenovo",
      model: "ThinkPad X1 Carbon Touch",
      description: "Incredibly thin and light business ultrabook with a 14-inch touch display.",
      condition: "Used",
      finish: "Black",
      price: "500",
      category: "Computers"
    },
    {
      title: "iPhone 15 Pro",
      brand: "Apple",
      model: "iPhone 15 Pro",
      description: "Latest Apple flagship with titanium design and A17 Pro chip.",
      condition: "New",
      finish: "Silver",
      price: "1200",
      category: "Phones"
    },
    {
      title: "Samsung 4K TV",
      brand: "Samsung",
      model: "QN90C Neo QLED",
      description: "55 inch 4K Smart TV with quantum dot technology.",
      condition: "New",
      finish: "Black",
      price: "1500",
      category: "Electronics"
    }
  ]

  products.each do |attrs|
    Product.create!(attrs.merge(user: user))
  end
end
