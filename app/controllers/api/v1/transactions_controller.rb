class Api::V1::TransactionsController < ApplicationController

  def index
    render json: TransactionSerializer.new(Transactoin.all)
  end

end
