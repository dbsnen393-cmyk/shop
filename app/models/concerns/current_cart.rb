module CurrentCart
  extend ActiveSupport::Concern

  private

  def set_cart
    if user_signed_in?
      # If there's a guest cart in session, merge it into the user's cart
      if session[:cart_id]
        guest_cart = Cart.find_by(id: session[:cart_id])
        if guest_cart && guest_cart.user_id.nil?
          user_cart = Cart.find_by(user_id: current_user.id) || Cart.create(user_id: current_user.id)
          guest_cart.line_items.each do |item|
            existing = user_cart.line_items.find_by(product_id: item.product_id)
            if existing
              existing.increment!(:quantity, item.quantity)
            else
              item.update!(cart_id: user_cart.id)
            end
          end
          guest_cart.reload.destroy if guest_cart.line_items.empty?
          session[:cart_id] = user_cart.id
        end
      end
      @cart = Cart.find_by(user_id: current_user.id) || Cart.create(user_id: current_user.id)
      session[:cart_id] = @cart.id
    else
      @cart = Cart.find_by(id: session[:cart_id])
      if @cart.nil?
        @cart = Cart.create
        session[:cart_id] = @cart.id
      end
    end
  end
end
