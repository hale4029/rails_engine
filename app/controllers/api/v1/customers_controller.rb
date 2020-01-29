class Api::V1::CostomersController < ApplicationController

  def index
    render json: CostomerSerializer.new(Costomer.all)
  end


end
