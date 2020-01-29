require 'rails_helper'

describe "biz intelligence" do
  before :each do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    item_1 = create(:item, merchant: merchant_1)
    item_2 = create(:item, merchant: merchant_2)
    # @created_at_1 = Date.strptime('01-01-2020', '%m-%d-%Y')
    # @created_at_2 = Date.strptime('01-19-2020', '%m-%d-%Y')
    @created_at_1 = '2012-03-16T14:54:05.000Z'
    @created_at_2 = '2012-03-07T14:54:05.000Z'
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
    date_one = "2012-03-16"
    date_two = "2012-03-07"
    total_revenue_1 = ((@invoice_item_1.quantity * @invoice_item_1.unit_price) +
                    (@invoice_item_2.quantity * @invoice_item_2.unit_price))
    total_revenue_2 = ((@invoice_item_3.quantity * @invoice_item_3.unit_price) +
                    (@invoice_item_4.quantity * @invoice_item_4.unit_price))

    get "/api/v1/merchants/revenue?date=#{date_one}"       #{Time.now.strftime('%m/%d/%Y')}"

    expect(response).to be_successful
    result = JSON.parse(response.body).to_int
    expect(result).to eq(total_revenue_1)

    get "/api/v1/merchants/revenue?date=#{date_two}"       #{Time.now.strftime('%m/%d/%Y')}"

    expect(response).to be_successful
    result = JSON.parse(response.body).to_int
    expect(result).to eq(total_revenue_2)
  end

  it "highest grossing merchant by revenue" do
  end
end
