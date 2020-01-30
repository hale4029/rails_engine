require 'rails_helper'

describe "Customer API" do
  it "sends a list of customers" do
    create_list(:customer, 3)

    get '/api/v1/customers'

    expect(response).to be_successful

    customers = JSON.parse(response.body)['data']
    expect(customers.count).to eq(3)
   end

  it "customer show request" do
    customer = create(:customer)

    get "/api/v1/customers/#{customer.id}"

    expect(response).to be_successful

    customer = JSON.parse(response.body)['data']

    expect(customer['attributes'].keys).to include('id')
    expect(customer['attributes'].keys).to include('first_name')
    expect(customer['attributes'].keys).to include('last_name')
    expect(customer['attributes'].keys).to_not include('created_at')
    expect(customer['attributes'].keys).to_not include('updated_at')
   end

  it "customer find request: ID" do
    customer = create(:customer)

    get "/api/v1/customers/find?id=#{customer.id}"

    expect(response).to be_successful

    customer = JSON.parse(response.body)['data']

    expect(customer['attributes'].keys).to include('id')
    expect(customer['attributes'].keys).to include('first_name')
    expect(customer['attributes'].keys).to include('last_name')
    expect(customer['attributes'].keys).to_not include('created_at')
    expect(customer['attributes'].keys).to_not include('updated_at')
   end

  it "customer find request: FIRST_NAME" do
    customer = create(:customer)

    get "/api/v1/customers/find?first_name=#{customer.first_name}"

    expect(response).to be_successful

    customer = JSON.parse(response.body)['data']

    expect(customer['attributes'].keys).to include('id')
    expect(customer['attributes'].keys).to include('first_name')
    expect(customer['attributes'].keys).to include('last_name')
    expect(customer['attributes'].keys).to_not include('created_at')
    expect(customer['attributes'].keys).to_not include('updated_at')
   end

  it "customer find request: LAST_NAME" do
    customer = create(:customer)

    get "/api/v1/customers/find?last_name=#{customer.last_name}"

    expect(response).to be_successful

    customer = JSON.parse(response.body)['data']

    expect(customer['attributes'].keys).to include('id')
    expect(customer['attributes'].keys).to include('first_name')
    expect(customer['attributes'].keys).to include('last_name')
    expect(customer['attributes'].keys).to_not include('created_at')
    expect(customer['attributes'].keys).to_not include('updated_at')
   end

  it "customer find request: CREATED AT" do
    customer = create(:customer, created_at: '2012-03-28T14:54:05.000Z')

    get "/api/v1/customers/find?created_at=#{customer.created_at.to_s}"

    expect(response).to be_successful

    customer = JSON.parse(response.body)['data']

    expect(customer['attributes'].keys).to include('id')
    expect(customer['attributes'].keys).to include('first_name')
    expect(customer['attributes'].keys).to include('last_name')
    expect(customer['attributes'].keys).to_not include('created_at')
    expect(customer['attributes'].keys).to_not include('updated_at')
   end

  it "customer find request: UPDATED AT" do
    customer = create(:customer, updated_at: '2012-03-28T14:54:05.000Z')

    get "/api/v1/customers/find?updated_at=#{customer.updated_at.to_s}"

    expect(response).to be_successful

    customer = JSON.parse(response.body)['data']

    expect(customer['attributes'].keys).to include('id')
    expect(customer['attributes'].keys).to include('first_name')
    expect(customer['attributes'].keys).to include('last_name')
    expect(customer['attributes'].keys).to_not include('created_at')
    expect(customer['attributes'].keys).to_not include('updated_at')
   end

   it "customer find_all request: ID" do
     customer = create(:customer)

     get "/api/v1/customers/find_all?id=#{customer.id}"

     expect(response).to be_successful

     customer = JSON.parse(response.body)['data']

     expect(customer.class).to eq(Array)
     expect(customer.length).to eq(1)

     customer = customer.first
     expect(customer['attributes'].keys).to include('id')
     expect(customer['attributes'].keys).to include('first_name')
     expect(customer['attributes'].keys).to include('last_name')
     expect(customer['attributes'].keys).to_not include('created_at')
     expect(customer['attributes'].keys).to_not include('updated_at')
    end

   it "customer find_all request: first_name" do
     customer = create(:customer, first_name: 'Harry')
     create(:customer, first_name: 'Harry')
     create(:customer, first_name: 'Linda')

     get "/api/v1/customers/find_all?first_name=#{customer.first_name}"

     expect(response).to be_successful

     customer = JSON.parse(response.body)['data']

     expect(customer.class).to eq(Array)
     expect(customer.length).to eq(2)

     customer = customer.first
     expect(customer['attributes'].keys).to include('id')
     expect(customer['attributes'].keys).to include('first_name')
     expect(customer['attributes'].keys).to include('last_name')
     expect(customer['attributes'].keys).to_not include('created_at')
     expect(customer['attributes'].keys).to_not include('updated_at')
    end

   it "customer find_all request: last_name" do
     customer = create(:customer, last_name: 'Levin')
     create(:customer, last_name: 'Levin')
     create(:customer, last_name: 'Mockus')

     get "/api/v1/customers/find_all?last_name=#{customer.last_name}"

     expect(response).to be_successful

     customer = JSON.parse(response.body)['data']

     expect(customer.class).to eq(Array)
     expect(customer.length).to eq(2)

     customer = customer.first
     expect(customer['attributes'].keys).to include('id')
     expect(customer['attributes'].keys).to include('first_name')
     expect(customer['attributes'].keys).to include('last_name')
     expect(customer['attributes'].keys).to_not include('created_at')
     expect(customer['attributes'].keys).to_not include('updated_at')
    end

   it "customer find_all request: CREATED AT" do
     customer = create(:customer, created_at: '2012-03-28T14:54:05.000Z')
     create(:customer, created_at: '2012-03-28T14:54:05.000Z')
     create(:customer, created_at: '2012-03-29T14:54:05.000Z')

     get "/api/v1/customers/find_all?created_at='2012-03-28T14:54:05.000Z'"

     expect(response).to be_successful

     customer = JSON.parse(response.body)['data']

     expect(customer.class).to eq(Array)
     expect(customer.length).to eq(2)
    end

   it "customer find_all request: UPDATED AT" do
     customer = create(:customer, updated_at: '2012-03-28T14:54:05.000Z')
     create(:customer, updated_at: '2012-03-28T14:54:05.000Z')
     create(:customer, updated_at: '2012-03-29T14:54:05.000Z')

     get "/api/v1/customers/find_all?updated_at='2012-03-28T14:54:05.000Z'"

     expect(response).to be_successful

     customer = JSON.parse(response.body)['data']

     expect(customer.class).to eq(Array)
     expect(customer.length).to eq(2)
    end

  it "random mechant" do
    create_list(:customer, 100)

    get "/api/v1/customers/random"

    expect(response).to be_successful
    customer = JSON.parse(response.body)['data']

    id = customer['attributes']['id']

    expect(customer['attributes'].keys).to include('id')
    expect(customer['attributes'].keys).to include('first_name')
    expect(customer['attributes'].keys).to include('last_name')
    expect(customer['attributes'].keys).to_not include('created_at')
    expect(customer['attributes'].keys).to_not include('updated_at')

    get "/api/v1/customers/random"

    expect(response).to be_successful
    customer = JSON.parse(response.body)['data']

    expect(customer['attributes']['id']).to_not eq(id)
  end

 end
