require 'rails_helper'

describe "Mechant API" do
  it "sends a list of merchants" do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    expect(response).to be_successful

    merchants = JSON.parse(response.body)['data']
    expect(merchants.count).to eq(3)
   end

  it "merchant show request" do
    merchant = create(:merchant)

    get "/api/v1/merchants/#{merchant.id}"

    expect(response).to be_successful

    merchant = JSON.parse(response.body)['data']

    expect(merchant['attributes'].keys).to include('id')
    expect(merchant['attributes'].keys).to include('name')
    expect(merchant['attributes'].keys).to_not include('created_at')
    expect(merchant['attributes'].keys).to_not include('updated_at')
   end

  it "merchant find request: ID" do
    merchant = create(:merchant)

    get "/api/v1/merchants/find?merchant_id=#{merchant.id}"

    expect(response).to be_successful

    merchant = JSON.parse(response.body)['data']

    expect(merchant['attributes'].keys).to include('id')
    expect(merchant['attributes'].keys).to include('name')
    expect(merchant['attributes'].keys).to_not include('created_at')
    expect(merchant['attributes'].keys).to_not include('updated_at')
   end

  it "merchant find request: NAME" do
    merchant = create(:merchant)

    get "/api/v1/merchants/find?name=#{merchant.name}"

    expect(response).to be_successful

    merchant = JSON.parse(response.body)['data']

    expect(merchant['attributes'].keys).to include('id')
    expect(merchant['attributes'].keys).to include('name')
    expect(merchant['attributes'].keys).to_not include('created_at')
    expect(merchant['attributes'].keys).to_not include('updated_at')
   end

  it "merchant find request: CREATED AT" do
    merchant = create(:merchant)

    get "/api/v1/merchants/find?created_at=#{merchant.created_at.to_s}"

    expect(response).to be_successful

    merchant = JSON.parse(response.body)['data']

    expect(merchant['attributes'].keys).to include('id')
    expect(merchant['attributes'].keys).to include('name')
    expect(merchant['attributes'].keys).to_not include('created_at')
    expect(merchant['attributes'].keys).to_not include('updated_at')
   end

  it "merchant find request: UPDATED AT" do
    merchant = create(:merchant)

    get "/api/v1/merchants/find?updated_at=#{merchant.updated_at.to_s}"

    expect(response).to be_successful

    merchant = JSON.parse(response.body)['data']

    expect(merchant['attributes'].keys).to include('id')
    expect(merchant['attributes'].keys).to include('name')
    expect(merchant['attributes'].keys).to_not include('created_at')
    expect(merchant['attributes'].keys).to_not include('updated_at')
   end

   it "merchant find_all request: ID" do
     merchant = create(:merchant)

     get "/api/v1/merchants/find_all?merchant_id=#{merchant.id}"

     expect(response).to be_successful

     merchant = JSON.parse(response.body)['data']

     expect(merchant.class).to eq(Array)
     expect(merchant.length).to eq(1)

     merchant = merchant.first
     expect(merchant['attributes'].keys).to include('id')
     expect(merchant['attributes'].keys).to include('name')
     expect(merchant['attributes'].keys).to_not include('created_at')
     expect(merchant['attributes'].keys).to_not include('updated_at')
    end

   it "merchant find_all request: NAME" do
     merchant = create(:merchant, name: 'Harry')
     merchant = create(:merchant, name: 'Harry')

     get "/api/v1/merchants/find_all?name=#{merchant.name}"

     expect(response).to be_successful

     merchant = JSON.parse(response.body)['data']

     expect(merchant.class).to eq(Array)
     expect(merchant.length).to eq(2)

     merchant = merchant.first
     expect(merchant['attributes'].keys).to include('id')
     expect(merchant['attributes'].keys).to include('name')
     expect(merchant['attributes'].keys).to_not include('created_at')
     expect(merchant['attributes'].keys).to_not include('updated_at')
    end

   it "merchant find_all request: CREATED AT" do
     merchant = create(:merchant, created_at: (Time.now - 5.days))
     create(:merchant, created_at: (Time.now - 5.days))
     create(:merchant, created_at: (Time.now - 6.days))

     get "/api/v1/merchants/find_all?created_at=#{merchant.created_at.to_s}"

     expect(response).to be_successful

     merchant = JSON.parse(response.body)['data']

     expect(merchant.class).to eq(Array)
     expect(merchant.length).to eq(2)
    end

   it "merchant find_all request: UPDATED AT" do
     merchant = create(:merchant, updated_at: (Time.now - 5.days))
     create(:merchant, updated_at: (Time.now - 5.days))
     create(:merchant, updated_at: (Time.now - 6.days))

     get "/api/v1/merchants/find_all?updated_at=#{merchant.updated_at.to_s}"

     expect(response).to be_successful

     merchant = JSON.parse(response.body)['data']

     expect(merchant.class).to eq(Array)
     expect(merchant.length).to eq(2)
    end

  it "random mechant" do
    create_list(:merchant, 100)

    get "/api/v1/merchants/random"

    expect(response).to be_successful
    merchant = JSON.parse(response.body)['data']

    id = merchant['attributes']['id']

    expect(merchant['attributes'].keys).to include('id')
    expect(merchant['attributes'].keys).to include('name')
    expect(merchant['attributes'].keys).to_not include('created_at')
    expect(merchant['attributes'].keys).to_not include('updated_at')

    get "/api/v1/merchants/random"

    expect(response).to be_successful
    merchant = JSON.parse(response.body)['data']
    require "pry"; binding.pry
    expect(merchant['attributes']['id']).to_not eq(id)
  end

 end
