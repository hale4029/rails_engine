class Api::V1::ItemsController < ApplicationController

  def index
    resource = Item.find_resource(params)
    render json: ItemSerializer.new(resource.items)
  end

end
