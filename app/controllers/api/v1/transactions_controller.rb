class Api::V1::TransactionsController < ApplicationController

  def index
    resource = Transaction.find_resource(params)
    render json: TransactionSerializer.new(resource.transactions)
  end

end
