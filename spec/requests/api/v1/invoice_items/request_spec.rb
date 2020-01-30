require 'rails_helper'

describe "invoice_item API" do
  it "sends a list of invoice_items" do
    create_list(:invoice_item, 3)

    get '/api/v1/invoice_items'

    expect(response).to be_successful

    invoice_items = JSON.parse(response.body)['data']
    expect(invoice_items.count).to eq(3)
   end

  it "invoice_item show request" do
    invoice_item = create(:invoice_item)

    get "/api/v1/invoice_items/#{invoice_item.id}"

    expect(response).to be_successful

    invoice_item = JSON.parse(response.body)['data']

    expect(invoice_item['attributes'].keys).to include('id')
    expect(invoice_item['attributes'].keys).to include('item_id')
    expect(invoice_item['attributes'].keys).to include('invoice_id')
    expect(invoice_item['attributes'].keys).to include('unit_price')
    expect(invoice_item['attributes'].keys).to include('quantity')
    expect(invoice_item['attributes'].keys).to_not include('created_at')
    expect(invoice_item['attributes'].keys).to_not include('updated_at')
   end

  it "invoice_item find request: ID" do
    invoice_item = create(:invoice_item)

    get "/api/v1/invoice_items/find?id=#{invoice_item.id}"

    expect(response).to be_successful

    invoice_item = JSON.parse(response.body)['data']

    expect(invoice_item['attributes'].keys).to include('id')
    expect(invoice_item['attributes'].keys).to include('item_id')
    expect(invoice_item['attributes'].keys).to include('invoice_id')
    expect(invoice_item['attributes'].keys).to include('unit_price')
    expect(invoice_item['attributes'].keys).to include('quantity')
    expect(invoice_item['attributes'].keys).to_not include('created_at')
    expect(invoice_item['attributes'].keys).to_not include('updated_at')
   end

  it "invoice_item find request: item_id" do
    invoice_item = create(:invoice_item)

    get "/api/v1/invoice_items/find?item_id=#{invoice_item.item_id}"

    expect(response).to be_successful

    invoice_item = JSON.parse(response.body)['data']

    expect(invoice_item['attributes'].keys).to include('id')
    expect(invoice_item['attributes'].keys).to include('item_id')
    expect(invoice_item['attributes'].keys).to include('invoice_id')
    expect(invoice_item['attributes'].keys).to include('unit_price')
    expect(invoice_item['attributes'].keys).to include('quantity')
    expect(invoice_item['attributes'].keys).to_not include('created_at')
    expect(invoice_item['attributes'].keys).to_not include('updated_at')
   end

  it "invoice_item find request: invoice_id" do
    invoice_item = create(:invoice_item)

    get "/api/v1/invoice_items/find?invoice_id=#{invoice_item.invoice_id}"

    expect(response).to be_successful

    invoice_item = JSON.parse(response.body)['data']

    expect(invoice_item['attributes'].keys).to include('id')
    expect(invoice_item['attributes'].keys).to include('item_id')
    expect(invoice_item['attributes'].keys).to include('invoice_id')
    expect(invoice_item['attributes'].keys).to include('unit_price')
    expect(invoice_item['attributes'].keys).to include('quantity')
    expect(invoice_item['attributes'].keys).to_not include('created_at')
    expect(invoice_item['attributes'].keys).to_not include('updated_at')
   end

  it "invoice_item find request: unit_price" do
    invoice_item = create(:invoice_item, unit_price: 83363)
    unit_price = '833.63'

    get "/api/v1/invoice_items/find?unit_price=#{unit_price}"

    expect(response).to be_successful

    invoice_item = JSON.parse(response.body)['data']

    expect(invoice_item['attributes'].keys).to include('id')
    expect(invoice_item['attributes'].keys).to include('item_id')
    expect(invoice_item['attributes'].keys).to include('invoice_id')
    expect(invoice_item['attributes'].keys).to include('unit_price')
    expect(invoice_item['attributes'].keys).to include('quantity')
    expect(invoice_item['attributes'].keys).to_not include('created_at')
    expect(invoice_item['attributes'].keys).to_not include('updated_at')
   end

  it "invoice_item find request: quantity" do
    invoice_item = create(:invoice_item)

    get "/api/v1/invoice_items/find?quantity=#{invoice_item.quantity}"

    expect(response).to be_successful

    invoice_item = JSON.parse(response.body)['data']

    expect(invoice_item['attributes'].keys).to include('id')
    expect(invoice_item['attributes'].keys).to include('item_id')
    expect(invoice_item['attributes'].keys).to include('invoice_id')
    expect(invoice_item['attributes'].keys).to include('unit_price')
    expect(invoice_item['attributes'].keys).to include('quantity')
    expect(invoice_item['attributes'].keys).to_not include('created_at')
    expect(invoice_item['attributes'].keys).to_not include('updated_at')
   end

  it "invoice_item find request: CREATED AT" do
    invoice_item = create(:invoice_item, created_at: '2012-03-28T14:54:05.000Z')

    get "/api/v1/invoice_items/find?created_at=#{invoice_item.created_at.to_s}"

    expect(response).to be_successful

    invoice_item = JSON.parse(response.body)['data']

    expect(invoice_item['attributes'].keys).to include('id')
    expect(invoice_item['attributes'].keys).to include('item_id')
    expect(invoice_item['attributes'].keys).to include('invoice_id')
    expect(invoice_item['attributes'].keys).to include('unit_price')
    expect(invoice_item['attributes'].keys).to include('quantity')
    expect(invoice_item['attributes'].keys).to_not include('created_at')
    expect(invoice_item['attributes'].keys).to_not include('updated_at')
   end

  it "invoice_item find request: UPDATED AT" do
    invoice_item = create(:invoice_item, updated_at: '2012-03-28T14:54:05.000Z')

    get "/api/v1/invoice_items/find?updated_at=#{invoice_item.updated_at.to_s}"

    expect(response).to be_successful

    invoice_item = JSON.parse(response.body)['data']

    expect(invoice_item['attributes'].keys).to include('id')
    expect(invoice_item['attributes'].keys).to include('item_id')
    expect(invoice_item['attributes'].keys).to include('invoice_id')
    expect(invoice_item['attributes'].keys).to include('unit_price')
    expect(invoice_item['attributes'].keys).to include('quantity')
    expect(invoice_item['attributes'].keys).to_not include('created_at')
    expect(invoice_item['attributes'].keys).to_not include('updated_at')
   end

   it "invoice_item find_all request: ID" do
     invoice_item = create(:invoice_item)

     get "/api/v1/invoice_items/find_all?id=#{invoice_item.id}"

     expect(response).to be_successful

     invoice_item = JSON.parse(response.body)['data']

     expect(invoice_item.class).to eq(Array)
     expect(invoice_item.length).to eq(1)

     invoice_item = invoice_item.first
     expect(invoice_item['attributes'].keys).to include('id')
     expect(invoice_item['attributes'].keys).to include('item_id')
     expect(invoice_item['attributes'].keys).to include('invoice_id')
     expect(invoice_item['attributes'].keys).to include('unit_price')
     expect(invoice_item['attributes'].keys).to include('quantity')
     expect(invoice_item['attributes'].keys).to_not include('created_at')
     expect(invoice_item['attributes'].keys).to_not include('updated_at')
    end

   it "invoice_item find_all request: item_id" do
     item = create(:item)
     item_2 = create(:item)
     invoice_item = create(:invoice_item, item_id: item.id)
     create(:invoice_item, item_id: item.id)
     create(:invoice_item, item_id: item_2.id)

     get "/api/v1/invoice_items/find_all?item_id=#{invoice_item.item_id}"

     expect(response).to be_successful

     invoice_item = JSON.parse(response.body)['data']

     expect(invoice_item.class).to eq(Array)
     expect(invoice_item.length).to eq(2)

     invoice_item = invoice_item.first
     expect(invoice_item['attributes'].keys).to include('id')
     expect(invoice_item['attributes'].keys).to include('item_id')
     expect(invoice_item['attributes'].keys).to include('invoice_id')
     expect(invoice_item['attributes'].keys).to include('unit_price')
     expect(invoice_item['attributes'].keys).to include('quantity')
     expect(invoice_item['attributes'].keys).to_not include('created_at')
     expect(invoice_item['attributes'].keys).to_not include('updated_at')
    end

   it "invoice_item find_all request: invoice_id" do
     invoice = create(:invoice)
     invoice_2 = create(:invoice)
     invoice_item = create(:invoice_item, invoice_id: invoice.id)
     create(:invoice_item, invoice_id: invoice.id)
     create(:invoice_item, invoice_id: invoice_2.id)

     get "/api/v1/invoice_items/find_all?invoice_id=#{invoice_item.invoice_id}"

     expect(response).to be_successful

     invoice_item = JSON.parse(response.body)['data']

     expect(invoice_item.class).to eq(Array)
     expect(invoice_item.length).to eq(2)

     invoice_item = invoice_item.first
     expect(invoice_item['attributes'].keys).to include('id')
     expect(invoice_item['attributes'].keys).to include('item_id')
     expect(invoice_item['attributes'].keys).to include('invoice_id')
     expect(invoice_item['attributes'].keys).to include('unit_price')
     expect(invoice_item['attributes'].keys).to include('quantity')
     expect(invoice_item['attributes'].keys).to_not include('created_at')
     expect(invoice_item['attributes'].keys).to_not include('updated_at')
    end

   it "invoice_item find_all request: unit_price" do
     invoice_item = create(:invoice_item, unit_price: 12)
     create(:invoice_item, unit_price: 12)
     create(:invoice_item, unit_price: 14)

     get "/api/v1/invoice_items/find_all?unit_price=0.12"

     expect(response).to be_successful

     invoice_item = JSON.parse(response.body)['data']

     expect(invoice_item.class).to eq(Array)
     expect(invoice_item.length).to eq(2)

     invoice_item = invoice_item.first
     expect(invoice_item['attributes'].keys).to include('id')
     expect(invoice_item['attributes'].keys).to include('item_id')
     expect(invoice_item['attributes'].keys).to include('invoice_id')
     expect(invoice_item['attributes'].keys).to include('unit_price')
     expect(invoice_item['attributes'].keys).to include('quantity')
     expect(invoice_item['attributes'].keys).to_not include('created_at')
     expect(invoice_item['attributes'].keys).to_not include('updated_at')
    end

   it "invoice_item find_all request: quantity" do
     invoice_item = create(:invoice_item, quantity: 12)
     create(:invoice_item, quantity: 12)
     create(:invoice_item, quantity: 14)

     get "/api/v1/invoice_items/find_all?quantity=#{invoice_item.quantity}"

     expect(response).to be_successful

     invoice_item = JSON.parse(response.body)['data']

     expect(invoice_item.class).to eq(Array)
     expect(invoice_item.length).to eq(2)

     invoice_item = invoice_item.first
     expect(invoice_item['attributes'].keys).to include('id')
     expect(invoice_item['attributes'].keys).to include('item_id')
     expect(invoice_item['attributes'].keys).to include('invoice_id')
     expect(invoice_item['attributes'].keys).to include('unit_price')
     expect(invoice_item['attributes'].keys).to include('quantity')
     expect(invoice_item['attributes'].keys).to_not include('created_at')
     expect(invoice_item['attributes'].keys).to_not include('updated_at')
    end

   it "invoice_item find_all request: CREATED AT" do
     invoice_item = create(:invoice_item, created_at: '2012-03-28T14:54:05.000Z')
     create(:invoice_item, created_at: '2012-03-28T14:54:05.000Z')
     create(:invoice_item, created_at: '2012-03-29T14:54:05.000Z')

     get "/api/v1/invoice_items/find_all?created_at='2012-03-28T14:54:05.000Z'"

     expect(response).to be_successful

     invoice_item = JSON.parse(response.body)['data']

     expect(invoice_item.class).to eq(Array)
     expect(invoice_item.length).to eq(2)
    end

   it "invoice_item find_all request: UPDATED AT" do
     invoice_item = create(:invoice_item, updated_at: '2012-03-28T14:54:05.000Z')
     create(:invoice_item, updated_at: '2012-03-28T14:54:05.000Z')
     create(:invoice_item, updated_at: '2012-03-29T14:54:05.000Z')

     get "/api/v1/invoice_items/find_all?updated_at='2012-03-28T14:54:05.000Z'"

     expect(response).to be_successful

     invoice_item = JSON.parse(response.body)['data']

     expect(invoice_item.class).to eq(Array)
     expect(invoice_item.length).to eq(2)
    end

  it "random mechant" do
    create_list(:invoice_item, 100)

    get "/api/v1/invoice_items/random"

    expect(response).to be_successful
    invoice_item = JSON.parse(response.body)['data']

    id = invoice_item['attributes']['id']

    expect(invoice_item['attributes'].keys).to include('id')
    expect(invoice_item['attributes'].keys).to include('item_id')
    expect(invoice_item['attributes'].keys).to include('invoice_id')
    expect(invoice_item['attributes'].keys).to include('unit_price')
    expect(invoice_item['attributes'].keys).to include('quantity')
    expect(invoice_item['attributes'].keys).to_not include('created_at')
    expect(invoice_item['attributes'].keys).to_not include('updated_at')

    get "/api/v1/invoice_items/random"

    expect(response).to be_successful
    invoice_item = JSON.parse(response.body)['data']

    expect(invoice_item['attributes']['id']).to_not eq(id)
  end

 end
