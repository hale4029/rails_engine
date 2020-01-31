class Api::V1::TransactionsController < ApplicationController

  def index
    render json: TransactionSerializer.new(Transaction.all)
  end

  def show
    render json: TransactionSerializer.new(Transaction.find_transaction(pass_params))
  end

  def service
    resource = ResourceFinder.find_resource(params)
    render json: TransactionSerializer.new(resource.transactions)
  end

  private

  def pass_params
    params.permit(:id, :invoice_id, :credit_card_number, :created_at, :updated_at, :slug, :result)
  end
end
