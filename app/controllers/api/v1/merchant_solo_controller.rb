class Api::V1::MerchantSoloController < ApplicationController

  # def service
  #   resource = ResourceFinder.find_resource(params)
  #   render json: MerchantSoloSerializer.new(resource.merchant)
  # end

  def revenue
    merchant = Merchant.find(params[:merchant_slug])
    render json: merchant.revenue
  end

  private

  def pass_params
    params.permit(:id, :name, :created_at, :updated_at, :slug, :date, :revenue, :most_revenue, :quantity)
  end

end
