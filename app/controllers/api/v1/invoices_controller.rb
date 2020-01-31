class Api::V1::InvoicesController < ApplicationController

  def index
    render json: InvoiceSerializer.new(Invoice.all)
  end

  def show
    render json: InvoiceSerializer.new(Invoice.find_invoice(pass_params))
  end

  def service
    resource = ResourceFinder.find_resource(params)
    if resource.class == InvoiceItem || resource.class == Transaction
      render json: InvoiceSerializer.new(resource.invoice)
    else
      render json: InvoiceSerializer.new(resource.invoices)
    end
  end

  private

  def pass_params
    params.permit(:id, :status, :customer_id, :created_at, :updated_at, :slug, :merchant_id)
  end


end
