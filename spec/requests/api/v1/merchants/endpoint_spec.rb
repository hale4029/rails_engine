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

describe "mechant/:id/items" do
  it "sends a list items for that mechant id" do
    merchant = create(:merchant)
    create_list(:item, 5, merchant: merchant)

    get "/api/v1/merchants/#{merchant.id}/items"

    expect(response).to be_successful

    items = JSON.parse(response.body)['data']
    expect(items.count).to eq(5)

    item = items.first
    expect(item['attributes'].keys).to include('id')
    expect(item['attributes'].keys).to include('name')
    expect(item['attributes'].keys).to include('description')
    expect(item['attributes'].keys).to include('unit_price')
    expect(item['attributes'].keys).to include('merchant_id')
    expect(item['attributes'].keys).to_not include('created_at')
    expect(item['attributes'].keys).to_not include('updated_at')
   end
end
