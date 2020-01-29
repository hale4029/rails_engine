require 'rails_helper'

describe "biz intelligence" do
  before :each do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    item_1 = create(:item, merchant: merchant_1)
    item_2 = create(:item, merchant: merchant_2)
    require "pry"; binding.pry
    @created_at_1 = Date.strptime('01-01-2020', '%m/%d/%Y')
    @created_at_2 = Date.strptime('01-19-2020', '%m/%d/%Y')
    invoice_1 = create(:invoice, merchant: merchant_1, created_at: @created_at_1)
    invoice_2 = create(:invoice, merchant: merchant_2, created_at: @created_at_1)
    invoice_3 = create(:invoice, merchant: merchant_1, created_at: @created_at_2)
    invoice_4 = create(:invoice, merchant: merchant_2, created_at: @created_at_2)
    @invoice_item_1 = create(:invoice_item, item: item_1, invoice: invoice_1, unit_price: item_1.unit_price, created_at: @created_at_1)
    @invoice_item_2 = create(:invoice_item, item: item_2, invoice: invoice_2, unit_price: item_2.unit_price, created_at: @created_at_1)
    @invoice_item_3 = create(:invoice_item, item: item_1, invoice: invoice_3, unit_price: item_1.unit_price, created_at: @created_at_2)
    @invoice_item_4 = create(:invoice_item, item: item_2, invoice: invoice_4, unit_price: item_2.unit_price, created_at: @created_at_2)
  end

  it "revenue across all merchants" do
    total_revenue = ((@invoice_item_1.quantity * @invoice_item_1.unit_price) +
                    (@invoice_item_2.quantity * @invoice_item_2.unit_price))

    get "/api/v1/merchants/revenue?date=#{@created_at_1}"       #{Time.now.strftime('%m/%d/%Y')}"

    expect(response).to be_successful
    require "pry"; binding.pry
    result = JSON.parse(response.body)['data']
    expect(result).to eq(total_revenue)
  end

  it "highest grossing merchant by revenue" do
  end
end
