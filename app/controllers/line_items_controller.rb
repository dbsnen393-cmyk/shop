class LineItemsController < ApplicationController
  def create
    product = Product.find(params[:product_id])
    existing = @cart.line_items.find_by(product_id: product.id)
    if existing
      existing.increment!(:quantity)
    else
      @cart.line_items.create!(product: product)
    end
    redirect_back(fallback_location: root_path, notice: "Added to your cart.")
  end

  def destroy
    @line_item = @cart.line_items.find_by(id: params[:id])
    if @line_item
      @line_item.destroy
      redirect_back(fallback_location: cart_path(@cart), notice: "Removed from your cart.")
    else
      redirect_to cart_path(@cart), alert: "Item not found."
    end
  end
end
