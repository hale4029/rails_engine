class Api::V1::MerchantSoloController < ApplicationController

  def revenue
    merchant = Merchant.find(params[:merchant_slug])
    render json: merchant.revenue
  end

  def customer
    merchant = Merchant.find(params[:merchant_slug])
    render json: MerchantSoloSerializer.new(merchant.favorite_customer)
  end

end
