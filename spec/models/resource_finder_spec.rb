require 'rails_helper'

describe "find resrouce" do

  it "invoice" do
    invoice = create(:invoice)
    hash = {'invoice_slug' => invoice.id}
    result = ResourceFinder.find_resource(hash)
    expect(result).to eq(invoice)
  end

  it "invoice_item" do
    invoice_item = create(:invoice_item)
    hash = {'invoice_item_slug' => invoice_item.id}
    result = ResourceFinder.find_resource(hash)
    expect(result).to eq(invoice_item)
  end

  it "transaction" do
    transaction = create(:transaction)
    hash = {'transaction_slug' => transaction.id}
    result = ResourceFinder.find_resource(hash)
    expect(result).to eq(transaction)
  end

  it "merchant" do
    merchant = create(:merchant)
    hash = {'merchant_slug' => merchant.id}
    result = ResourceFinder.find_resource(hash)
    expect(result).to eq(merchant)
  end

  it "item" do
    item = create(:item)
    hash = {'item_slug' => item.id}
    result = ResourceFinder.find_resource(hash)
    expect(result).to eq(item)
  end

  it "customer" do
    customer = create(:customer)
    hash = {'customer_slug' => customer.id}
    result = ResourceFinder.find_resource(hash)
    expect(result).to eq(customer)
  end
end
