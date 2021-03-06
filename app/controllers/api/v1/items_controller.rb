class Api::V1::ItemsController < ApplicationController

  def index
    render json: ItemSerializer.new(Item.all)
  end

  def show
    if params.values.include?('most_revenue')
      render json: ItemSerializer.new(Item.most_revenue(params[:quantity]))
    else
      render json: ItemSerializer.new(Item.find_item(pass_params))
    end
  end

  def service
    resource = ResourceFinder.find_resource(params)
    if resource.class == InvoiceItem
      render json: ItemSerializer.new(resource.item)
    else
      render json: ItemSerializer.new(resource.items)
    end
  end

  private

  def pass_params
    params.permit(:id, :name, :description, :created_at, :updated_at, :slug, :merchant_id, :unit_price)
  end
end
