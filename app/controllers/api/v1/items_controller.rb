class Api::V1::ItemsController < ApplicationController

  def index
    merchant = Merchnat.find(params[:id])
    render json: ItemSerializer.new(Item.all)
  end

end
