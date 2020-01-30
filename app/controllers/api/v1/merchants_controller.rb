class Api::V1::MerchantsController < ApplicationController

  def index
    render json: MerchantSerializer.new(Merchant.all)
  end

  def show
    if params.values.include?('revenue')
      render json: Merchant.find_merchant(pass_params)
    else
      render json: MerchantSerializer.new(Merchant.find_merchant(pass_params))
    end
  end


  private

  def pass_params
    params.permit(:id, :name, :created_at, :updated_at, :slug, :date, :revenue)
  end

end
