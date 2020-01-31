require 'rails_helper'

describe "item API" do
  it "sends a list of items" do
    create_list(:item, 3)

    get '/api/v1/items'

    expect(response).to be_successful

    items = JSON.parse(response.body)['data']
    expect(items.count).to eq(3)
   end

  it "item show request" do
    item = create(:item)

    get "/api/v1/items/#{item.id}"

    expect(response).to be_successful

    item = JSON.parse(response.body)['data']

    expect(item['attributes'].keys).to include('id')
    expect(item['attributes'].keys).to include('name')
    expect(item['attributes'].keys).to include('description')
    expect(item['attributes'].keys).to include('unit_price')
    expect(item['attributes'].keys).to include('merchant_id')
    expect(item['attributes'].keys).to_not include('created_at')
    expect(item['attributes'].keys).to_not include('updated_at')
   end

  it "item find request: ID" do
    item = create(:item)

    get "/api/v1/items/find?id=#{item.id}"

    expect(response).to be_successful

    item = JSON.parse(response.body)['data']

    expect(item['attributes'].keys).to include('id')
    expect(item['attributes'].keys).to include('name')
    expect(item['attributes'].keys).to include('description')
    expect(item['attributes'].keys).to include('unit_price')
    expect(item['attributes'].keys).to include('merchant_id')
    expect(item['attributes'].keys).to_not include('created_at')
    expect(item['attributes'].keys).to_not include('updated_at')
   end

  it "item find request: name" do
    item = create(:item)

    get "/api/v1/items/find?name=#{item.name}"

    expect(response).to be_successful

    item = JSON.parse(response.body)['data']

    expect(item['attributes'].keys).to include('id')
    expect(item['attributes'].keys).to include('name')
    expect(item['attributes'].keys).to include('description')
    expect(item['attributes'].keys).to include('unit_price')
    expect(item['attributes'].keys).to include('merchant_id')
    expect(item['attributes'].keys).to_not include('created_at')
    expect(item['attributes'].keys).to_not include('updated_at')
   end

  it "item find request: description" do
    item = create(:item)

    get "/api/v1/items/find?description=#{item.description}"

    expect(response).to be_successful

    item = JSON.parse(response.body)['data']

    expect(item['attributes'].keys).to include('id')
    expect(item['attributes'].keys).to include('name')
    expect(item['attributes'].keys).to include('description')
    expect(item['attributes'].keys).to include('unit_price')
    expect(item['attributes'].keys).to include('merchant_id')
    expect(item['attributes'].keys).to_not include('created_at')
    expect(item['attributes'].keys).to_not include('updated_at')
   end

  it "item find request: merchant_id" do
    merchant = create(:merchant)
    merchant_2 = create(:merchant)
    item = create(:item, merchant_id: merchant.id)
    create(:item, merchant_id: merchant.id)
    create(:item, merchant_id: merchant_2.id)

    get "/api/v1/items/find?merchant_id=#{item.merchant_id}"

    expect(response).to be_successful

    item = JSON.parse(response.body)['data']

    expect(item['attributes'].keys).to include('id')
    expect(item['attributes'].keys).to include('name')
    expect(item['attributes'].keys).to include('description')
    expect(item['attributes'].keys).to include('unit_price')
    expect(item['attributes'].keys).to include('merchant_id')
    expect(item['attributes'].keys).to_not include('created_at')
    expect(item['attributes'].keys).to_not include('updated_at')
   end

  it "item find request: unit_price" do
    item = create(:item, unit_price: 1111)

    get "/api/v1/items/find?unit_price=11.11"

    expect(response).to be_successful

    item = JSON.parse(response.body)['data']

    expect(item['attributes'].keys).to include('id')
    expect(item['attributes'].keys).to include('name')
    expect(item['attributes'].keys).to include('description')
    expect(item['attributes'].keys).to include('unit_price')
    expect(item['attributes'].keys).to include('merchant_id')
    expect(item['attributes'].keys).to_not include('created_at')
    expect(item['attributes'].keys).to_not include('updated_at')
   end

  it "item find request: CREATED AT" do
    item = create(:item, created_at: '2012-03-28T14:54:05.000Z')

    get "/api/v1/items/find?created_at=#{item.created_at.to_s}"

    expect(response).to be_successful

    item = JSON.parse(response.body)['data']

    expect(item['attributes'].keys).to include('id')
    expect(item['attributes'].keys).to include('name')
    expect(item['attributes'].keys).to include('description')
    expect(item['attributes'].keys).to include('unit_price')
    expect(item['attributes'].keys).to include('merchant_id')
    expect(item['attributes'].keys).to_not include('created_at')
    expect(item['attributes'].keys).to_not include('updated_at')
   end

  it "item find request: UPDATED AT" do
    item = create(:item, updated_at: '2012-03-28T14:54:05.000Z')

    get "/api/v1/items/find?updated_at=#{item.updated_at.to_s}"

    expect(response).to be_successful

    item = JSON.parse(response.body)['data']

    expect(item['attributes'].keys).to include('id')
    expect(item['attributes'].keys).to include('name')
    expect(item['attributes'].keys).to include('description')
    expect(item['attributes'].keys).to include('unit_price')
    expect(item['attributes'].keys).to include('merchant_id')
    expect(item['attributes'].keys).to_not include('created_at')
    expect(item['attributes'].keys).to_not include('updated_at')
   end

   it "item find_all request: ID" do
     item = create(:item)

     get "/api/v1/items/find_all?id=#{item.id}"

     expect(response).to be_successful

     item = JSON.parse(response.body)['data']

     expect(item.class).to eq(Array)
     expect(item.length).to eq(1)

     item = item.first
     expect(item['attributes'].keys).to include('id')
     expect(item['attributes'].keys).to include('name')
     expect(item['attributes'].keys).to include('description')
     expect(item['attributes'].keys).to include('unit_price')
     expect(item['attributes'].keys).to include('merchant_id')
     expect(item['attributes'].keys).to_not include('created_at')
     expect(item['attributes'].keys).to_not include('updated_at')
    end

   it "item find_all request: merchant_id" do
     merchant = create(:merchant)
     merchant_1 = create(:merchant)
     item = create(:item, merchant_id: merchant.id)
     create(:item, merchant_id: merchant.id)
     create(:item, merchant_id: merchant_1.id)

     get "/api/v1/items/find_all?merchant_id=#{merchant.id}"

     expect(response).to be_successful

     item = JSON.parse(response.body)['data']

     expect(item.class).to eq(Array)
     expect(item.length).to eq(2)

     item = item.first
     expect(item['attributes'].keys).to include('id')
     expect(item['attributes'].keys).to include('name')
     expect(item['attributes'].keys).to include('description')
     expect(item['attributes'].keys).to include('unit_price')
     expect(item['attributes'].keys).to include('merchant_id')
     expect(item['attributes'].keys).to_not include('created_at')
     expect(item['attributes'].keys).to_not include('updated_at')
    end

   it "item find_all request: name" do
     item = create(:item, name: "Air Pod")
     create(:item, name: "Air Pod")
     create(:item)

     get "/api/v1/items/find_all?name=#{item.name}"

     expect(response).to be_successful

     item = JSON.parse(response.body)['data']

     expect(item.class).to eq(Array)
     expect(item.length).to eq(2)

     item = item.first
     expect(item['attributes'].keys).to include('id')
     expect(item['attributes'].keys).to include('name')
     expect(item['attributes'].keys).to include('description')
     expect(item['attributes'].keys).to include('unit_price')
     expect(item['attributes'].keys).to include('merchant_id')
     expect(item['attributes'].keys).to_not include('created_at')
     expect(item['attributes'].keys).to_not include('updated_at')
    end

   it "item find_all request: description" do
     item = create(:item, description: "Blue")
     create(:item, description: "Blue")
     create(:item, description: "Grey")

     get "/api/v1/items/find_all?description=#{item.description}"

     expect(response).to be_successful

     item = JSON.parse(response.body)['data']

     expect(item.class).to eq(Array)
     expect(item.length).to eq(2)

     item = item.first
     expect(item['attributes'].keys).to include('id')
     expect(item['attributes'].keys).to include('name')
     expect(item['attributes'].keys).to include('description')
     expect(item['attributes'].keys).to include('unit_price')
     expect(item['attributes'].keys).to include('merchant_id')
     expect(item['attributes'].keys).to_not include('created_at')
     expect(item['attributes'].keys).to_not include('updated_at')
    end

   it "item find_all request: unit_price" do
     item = create(:item, unit_price: 1111)
     create(:item, unit_price: 1111)
     create(:item, unit_price: 2222)

     get "/api/v1/items/find_all?unit_price=11.11"

     expect(response).to be_successful

     item = JSON.parse(response.body)['data']

     expect(item.class).to eq(Array)
     expect(item.length).to eq(2)

     item = item.first
     expect(item['attributes'].keys).to include('id')
     expect(item['attributes'].keys).to include('name')
     expect(item['attributes'].keys).to include('description')
     expect(item['attributes'].keys).to include('unit_price')
     expect(item['attributes'].keys).to include('merchant_id')
     expect(item['attributes'].keys).to_not include('created_at')
     expect(item['attributes'].keys).to_not include('updated_at')
    end


   it "item find_all request: CREATED AT" do
     item = create(:item, created_at: '2012-03-28T14:54:05.000Z')
     create(:item, created_at: '2012-03-28T14:54:05.000Z')
     create(:item, created_at: '2012-03-29T14:54:05.000Z')

     get "/api/v1/items/find_all?created_at='2012-03-28T14:54:05.000Z'"

     expect(response).to be_successful

     item = JSON.parse(response.body)['data']

     expect(item.class).to eq(Array)
     expect(item.length).to eq(2)
    end

   it "item find_all request: UPDATED AT" do
     item = create(:item, updated_at: '2012-03-28T14:54:05.000Z')
     create(:item, updated_at: '2012-03-28T14:54:05.000Z')
     create(:item, updated_at: '2012-03-29T14:54:05.000Z')

     get "/api/v1/items/find_all?updated_at='2012-03-28T14:54:05.000Z'"

     expect(response).to be_successful

     item = JSON.parse(response.body)['data']

     expect(item.class).to eq(Array)
     expect(item.length).to eq(2)
    end

  it "random mechant" do
    create_list(:item, 100)

    get "/api/v1/items/random"

    expect(response).to be_successful
    item = JSON.parse(response.body)['data']

    id = item['attributes']['id']

    expect(item['attributes'].keys).to include('id')
    expect(item['attributes'].keys).to include('name')
    expect(item['attributes'].keys).to include('description')
    expect(item['attributes'].keys).to include('unit_price')
    expect(item['attributes'].keys).to include('merchant_id')
    expect(item['attributes'].keys).to_not include('created_at')
    expect(item['attributes'].keys).to_not include('updated_at')

    get "/api/v1/items/random"

    expect(response).to be_successful
    item = JSON.parse(response.body)['data']

    expect(item['attributes']['id']).to_not eq(id)
  end

 end
