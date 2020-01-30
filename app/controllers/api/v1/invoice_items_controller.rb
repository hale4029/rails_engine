class Api::V1::InvoiceItemsController < ApplicationController

  def index
    render json: InvoiceItemSerializer.new(InvoiceItem.all)
  end

  # def index
  #   resource = InvoiceItem.find_resource(params)
  #   render json: InvoiceItemSerializer.new(resource.invoice_items)
  # end

end
