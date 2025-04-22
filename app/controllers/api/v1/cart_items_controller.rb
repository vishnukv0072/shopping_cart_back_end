class Api::V1::CartItemsController < ApplicationController
  # skip_before_action :verify_authenticity_token

  def update
    action = params[:action_type]
    case action
    when "addItem"
      CartItem.create(product_id: params[:product_id], quantity: params[:quantity], user_id: current_user.id)
      render json: {message: "Item added successfully"}, status: 200
    else
      render json: {message: "Something's off"}
    end
  end

  private

  def cart_params
    # params.require(cart_it)
  end

end