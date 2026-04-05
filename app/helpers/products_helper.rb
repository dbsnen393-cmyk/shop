module ProductsHelper
  def product_author(product)
    product.user&.name || "Unknown"
  end
end
