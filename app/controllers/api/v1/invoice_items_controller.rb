class Api::V1::InvoiceItemsController < ApplicationController

  def index
    render json: InvoiceItemSerializer.new(InvoiceItem.all)
  end

  def show
    render json: InvoiceItemSerializer.new(InvoiceItem.find_invoice_item(pass_params))
  end

  def service
    resource = ResourceFinder.find_resource(params)
    render json: InvoiceItemSerializer.new(resource.invoice_items)
  end

  private

  def pass_params
    params.permit(:id, :item_id, :created_at, :updated_at, :slug, :invoice_id, :quantity, :unit_price)
  end

end
