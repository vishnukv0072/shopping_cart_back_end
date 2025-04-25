class Api::V1::CartItemsController < ApplicationController
  # skip_before_action :verify_authenticity_token

  def index
    if current_user
      render json: {cart_items: current_user.get_cart_items}
    else
      render json: { message: "User must be logged in to do this action" }
    end
  end

  def update
    if current_user
      action = params[:cart_item][:action_type]
      case action
      when "addItem"
        item = CartItem.create(cart_params.merge(user_id: current_user.id))
        render json: { message: "Item added successfully",
                       data: {unitPrice: item.unit_price, quantity: item.quantity, totalPrice: item.total_price}}, status: 200
      when "removeItem"
        current_user.cart_items.where(id: params[:cart_item][:product_id]).delete_all
        render json: { message: "Item removed successfully" }, status: 200
      when "increaseItemQuantity"
        item = current_user.cart_items.where(id: params[:cart_item][:product_id]).last
        # item.increment!(:quantity)
        item.update(quantity: item.quantity + 1)
        render json: { message: "Item quantity increased successfully", totalPrice: item.total_price }, status: 200
      when "decreaseItemQuantity"
        item = current_user.cart_items.where(id: params[:cart_item][:product_id]).last
        # item.decrement!(:quantity) does not trigger call_backs
        item.update(quantity: item.quantity - 1)
        render json: { message: "Item quantity decreased successfully", totalPrice: item.total_price }, status: 200
      when "clearCart"
        CartItem.where(user_id: current_user.id).delete_all
        render json: { message: "Cart cleared successfully" }, status: 200
      else
        #TODO - what if it falls here
        render json: { message: "The action type didn't match." }, status: 404
      end
    else
      render json: { message: "User must be logged in to do this action" }, status: 401
    end
  end

  private

  def cart_params
    params.require(:cart_item).permit(:id, :unit_price, :quantity)
  end

end