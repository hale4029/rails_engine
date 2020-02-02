class Api::V1::CustomerSoloController < ApplicationController

  def favorite_merchant
    customer = Customer.find(params[:customer_slug])
    render json: MerchantSerializer.new(customer.favorite_merchant)
  end

end
