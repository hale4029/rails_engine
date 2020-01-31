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

  # def service
  #   resource = Merchant.find_resource(params)
  #   render json: MerchantSerializer.new(resource.items)
  # end

  private

  def pass_params
    params.permit(:id, :name, :created_at, :updated_at, :slug, :date, :revenue)
  end

end
