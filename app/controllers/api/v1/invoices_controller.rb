class Api::V1::InvoicesController < ApplicationController

  def index
    render json: InvoiceSerializer.new(Invoice.all)
  end

  # def index
  #   merchant = Merchant.find(params[:merchant_slug])
  #   render json: InvoiceSerializer.new(merchant.invoices)
  # end

end
