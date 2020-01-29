class Api::V1::MerchantsController < ApplicationController

  def index
    render json: MerchantSerializer.new(Merchant.all)
  end

  def show
    if params.values.include?('revenue')
      render json: Merchant.find_merchant(params)
    else
      render json: MerchantSerializer.new(Merchant.find_merchant(params))
    end
  end

end
