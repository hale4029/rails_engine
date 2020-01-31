require 'rails_helper'

describe "invoices/:id/items" do
  it "sends a list items for that invoice id" do
    invoice = create(:invoice)
    7.times do
      item = create(:item)
      create(:invoice_item, invoice: invoice, item: item, unit_price: item.unit_price)
    end
    invoice_2 = create(:invoice)
    7.times do
      item = create(:item)
      create(:invoice_item, invoice: invoice_2, item: item, unit_price: item.unit_price)
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
    invoice_2 = create(:invoice)
    create_list(:transaction, 6, invoice: invoice_2)

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

describe "invoices/:id/invoice_items" do
  it "sends a list invoice_items for that invoice id" do
    invoice = create(:invoice)
    create_list(:invoice_item, 4, invoice: invoice)

    get "/api/v1/invoices/#{invoice.id}/invoice_items"

    expect(response).to be_successful

    invoice_items = JSON.parse(response.body)['data']
    expect(invoice_items.count).to eq(4)

    invoice_item = invoice_items.first
    expect(invoice_item['attributes'].keys).to include('id')
    expect(invoice_item['attributes'].keys).to include('item_id')
    expect(invoice_item['attributes'].keys).to include('invoice_id')
    expect(invoice_item['attributes'].keys).to include('quantity')
    expect(invoice_item['attributes'].keys).to include('unit_price')
    expect(invoice_item['attributes'].keys).to_not include('created_at')
    expect(invoice_item['attributes'].keys).to_not include('updated_at')
   end
end
