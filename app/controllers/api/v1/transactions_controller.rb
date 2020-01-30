class Api::V1::TransactionsController < ApplicationController

  def index
    render json: TransactionSerializer.new(Transaction.all)
  end


  def show

  end

  # def index
  #   resource = Transaction.find_resource(params)
  #   render json: TransactionSerializer.new(resource.transactions)
  # end

end
