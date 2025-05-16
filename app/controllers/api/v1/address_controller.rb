class Api::V1::AddressController < ApplicationController

  def index
    render json: { addresses: current_user.addresses, defaultAddress: current_user.default_address }
  end

end