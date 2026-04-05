class CartsController < ApplicationController
  before_action :set_cart_for_action, only: [:show, :destroy]

  def show
  end

  def destroy
    @cart.line_items.destroy_all
    redirect_to root_path, notice: "Cart has been emptied."
  end

  private

  def set_cart_for_action
    @cart = Cart.find(params[:id])
    unless @cart == current_cart
      redirect_to root_path, alert: "Not authorized."
    end
  end

  def current_cart
    @cart_for_check ||= Cart.find_by(id: session[:cart_id])
  end
end
