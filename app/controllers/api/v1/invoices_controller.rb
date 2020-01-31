class Api::V1::InvoicesController < ApplicationController

  def index
    render json: InvoiceSerializer.new(Invoice.all)
  end

  def show
    render json: InvoiceSerializer.new(Invoice.find_invoice(pass_params))
  end

  def service
    merchant = Merchant.find(params[:merchant_slug])
    render json: InvoiceSerializer.new(merchant.invoices)
  end

  private

  def pass_params
    params.permit(:id, :status, :customer_id, :created_at, :updated_at, :slug, :merchant_id)
  end


end
