class Api::V1::MerchantSoloController < ApplicationController

  # def service
  #   resource = ResourceFinder.find_resource(params)
  #   render json: MerchantSoloSerializer.new(resource.merchant)
  # end

  def revenue
    merchant = Merchant.find(params[:merchant_slug])
    render json: merchant.revenue
  end

  def customer
    merchant = Merchant.find(params[:merchant_slug])
    render json: MerchantSoloSerializer.new(merchant.favorite_customer)
  end

  private

  def pass_params
    params.permit(:id, :name, :created_at, :updated_at, :slug, :date, :revenue, :most_revenue, :quantity)
  end

end
