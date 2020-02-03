require 'rails_helper'

describe "biz logic revenue" do
  before :each do
    customer_1 = create(:customer)
    customer_2 = create(:customer)
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    @item_1 = create(:item, merchant: merchant_1, unit_price: 1000)
    @item_2 = create(:item, merchant: merchant_2, unit_price: 1000)
    created_at_1 = '2012-03-16T14:54:05.000Z'
    created_at_2 = '2012-03-07T14:54:05.000Z'
    invoice_1 = create(:invoice, merchant: merchant_1, created_at: created_at_1, customer_id: customer_1.id)
    invoice_2 = create(:invoice, merchant: merchant_2, created_at: created_at_1, customer_id: customer_1.id)
    @invoice_3 = create(:invoice, merchant: merchant_1, created_at: created_at_2, customer_id: customer_2.id)
    invoice_4 = create(:invoice, merchant: merchant_2, created_at: created_at_2, customer_id: customer_2.id)
    create(:invoice_item, item: @item_1, invoice: invoice_1, quantity: 2, unit_price: @item_1.unit_price, created_at: created_at_1)
    create(:invoice_item, item: @item_2, invoice: invoice_2, quantity: 2, unit_price: @item_2.unit_price, created_at: created_at_1)
    create(:invoice_item, item: @item_1, invoice: @invoice_3, quantity: 3, unit_price: @item_1.unit_price, created_at: created_at_2)
    create(:invoice_item, item: @item_2, invoice: invoice_4, quantity: 2, unit_price: @item_2.unit_price, created_at: created_at_2)
    create(:transaction, invoice_id: invoice_1.id)
    create(:transaction, invoice_id: invoice_2.id)
    create(:transaction, invoice_id: @invoice_3.id)
    create(:transaction, invoice_id: invoice_4.id)
  end

 it "item(s) with the most revenue" do
   result = Item.most_revenue(1)[0].id
   expect(result).to eq(@item_1.id)

   result = Item.most_revenue(2)[1].id
   expect(result).to eq(@item_2.id)
 end

 it "item's best day" do
   result = @item_1.best_day

   expect(result).to eq({:data=>{:attributes=>{:best_day=>"2012-03-07"}, :type=>"query_result"}})
 end
end
