class Api::V1::ItemsController < ApplicationController

  def index
    render json: ItemSerializer.new(Item.all)
  end

  # def index
  #   resource = Item.find_resource(params)
  #   render json: ItemSerializer.new(resource.items)
  # end

end
