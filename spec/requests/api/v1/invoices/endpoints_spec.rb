require 'rails_helper'

describe "invoices/:id/items" do
  it "sends a list items for that invoice id" do
    invoice = create(:invoice)
    7.times do
      item = create(:item)
      create(:invoice_item, invoice: invoice, item: item, unit_price: item.unit_price)
    end

    get "/api/v1/invoices/#{invoice.id}/items"

    expect(response).to be_successful

    items = JSON.parse(response.body)['data']
    expect(items.count).to eq(7)

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

describe "invoices/:id/transactions" do
  it "sends a list transaction for that invoice id" do
    invoice = create(:invoice)
    create_list(:transaction, 6, invoice: invoice)

    get "/api/v1/invoices/#{invoice.id}/transactions"

    expect(response).to be_successful

    transactions = JSON.parse(response.body)['data']
    expect(transactions.count).to eq(6)

    transaction = transactions.first
    expect(transaction['attributes'].keys).to include('id')
    expect(transaction['attributes'].keys).to include('invoice_id')
    expect(transaction['attributes'].keys).to include('credit_card_number')
    expect(transaction['attributes'].keys).to_not include('credit_card_expiration_date')
    expect(transaction['attributes'].keys).to include('result')
    expect(transaction['attributes'].keys).to_not include('created_at')
    expect(transaction['attributes'].keys).to_not include('updated_at')
   end
end
