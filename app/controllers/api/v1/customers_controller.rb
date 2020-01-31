class Api::V1::CustomersController < ApplicationController

  def index
    render json: CustomerSerializer.new(Customer.all)
  end

  def show
    render json: CustomerSerializer.new(Customer.find_customer(pass_params))
  end

  private

  def pass_params
    params.permit(:id, :first_name, :created_at, :updated_at, :slug, :last_name)
  end

end
