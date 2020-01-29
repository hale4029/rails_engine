require 'rails_helper'

describe "mechant/:id/invoices" do
  it "sends a list items for that mechant id" do
    merchant = create(:merchant)
    5.times do
      customer = create(:customer)
      create(:invoice, merchant: merchant, customer: customer)
    end

    get "/api/v1/merchants/#{merchant.id}/invoices"

    expect(response).to be_successful

    invoices = JSON.parse(response.body)['data']
    expect(invoices.count).to eq(5)

    invoice = invoices.first
    expect(invoice['attributes'].keys).to include('id')
    expect(invoice['attributes'].keys).to include('customer_id')
    expect(invoice['attributes'].keys).to include('merchant_id')
    expect(invoice['attributes'].keys).to include('status')
    expect(invoice['attributes'].keys).to_not include('created_at')
    expect(invoice['attributes'].keys).to_not include('updated_at')
   end
end
