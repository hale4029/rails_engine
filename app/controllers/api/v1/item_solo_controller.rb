class Api::V1::ItemSoloController < ApplicationController

  def best_day
    item = Item.find(params[:item_slug])
    render json: item.best_day
  end

end
