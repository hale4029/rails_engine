class Api::V1::ItemsController < ApplicationController

  def index
    render json: ItemSerializer.new(Item.all)
  end

  def show
    render json: ItemSerializer.new(Item.find_item(pass_params))
  end

  def service
    require "pry"; binding.pry
    resource = Item.find_resource(params)
    render json: ItemSerializer.new(resource.items)
  end

  private

  def pass_params
    params.permit(:id, :name, :description, :created_at, :updated_at, :slug, :date, :merchant_id, :unit_price)
  end
end
