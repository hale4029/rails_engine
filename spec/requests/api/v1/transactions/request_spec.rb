require 'rails_helper'

describe "transaction API" do
  it "sends a list of transactions" do
    create_list(:transaction, 3)

    get '/api/v1/transactions'

    expect(response).to be_successful

    transactions = JSON.parse(response.body)['data']
    expect(transactions.count).to eq(3)
   end

  it "transaction show request" do
    transaction = create(:transaction)

    get "/api/v1/transactions/#{transaction.id}"

    expect(response).to be_successful

    transaction = JSON.parse(response.body)['data']

    expect(transaction['attributes'].keys).to include('id')
    expect(transaction['attributes'].keys).to include('invoice_id')
    expect(transaction['attributes'].keys).to include('credit_card_number')
    expect(transaction['attributes'].keys).to include('result')
    expect(transaction['attributes'].keys).to_not include('created_at')
    expect(transaction['attributes'].keys).to_not include('updated_at')
   end

  it "transaction find request: ID" do
    transaction = create(:transaction)

    get "/api/v1/transactions/find?id=#{transaction.id}"

    expect(response).to be_successful

    transaction = JSON.parse(response.body)['data']

    expect(transaction['attributes'].keys).to include('id')
    expect(transaction['attributes'].keys).to include('invoice_id')
    expect(transaction['attributes'].keys).to include('credit_card_number')
    expect(transaction['attributes'].keys).to include('result')
    expect(transaction['attributes'].keys).to_not include('created_at')
    expect(transaction['attributes'].keys).to_not include('updated_at')
   end

  it "transaction find request: customer_id" do
    transaction = create(:transaction)

    get "/api/v1/transactions/find?customer_id=#{transaction.customer_id}"

    expect(response).to be_successful

    transaction = JSON.parse(response.body)['data']

    expect(transaction['attributes'].keys).to include('id')
    expect(transaction['attributes'].keys).to include('invoice_id')
    expect(transaction['attributes'].keys).to include('credit_card_number')
    expect(transaction['attributes'].keys).to include('result')
    expect(transaction['attributes'].keys).to_not include('created_at')
    expect(transaction['attributes'].keys).to_not include('updated_at')
   end

  it "transaction find request: merchant_id" do
    transaction = create(:transaction)

    get "/api/v1/transactions/find?merchant_id=#{transaction.merchant_id}"

    expect(response).to be_successful

    transaction = JSON.parse(response.body)['data']

    expect(transaction['attributes'].keys).to include('id')
    expect(transaction['attributes'].keys).to include('invoice_id')
    expect(transaction['attributes'].keys).to include('credit_card_number')
    expect(transaction['attributes'].keys).to include('result')
    expect(transaction['attributes'].keys).to_not include('created_at')
    expect(transaction['attributes'].keys).to_not include('updated_at')
   end

  it "transaction find request: status" do
    transaction = create(:transaction, status: 'happy')

    get "/api/v1/transactions/find?status=#{transaction.status}"

    expect(response).to be_successful

    transaction = JSON.parse(response.body)['data']

    expect(transaction['attributes'].keys).to include('id')
    expect(transaction['attributes'].keys).to include('invoice_id')
    expect(transaction['attributes'].keys).to include('credit_card_number')
    expect(transaction['attributes'].keys).to include('result')
    expect(transaction['attributes'].keys).to_not include('created_at')
    expect(transaction['attributes'].keys).to_not include('updated_at')
   end

  it "transaction find request: CREATED AT" do
    transaction = create(:transaction, created_at: '2012-03-28T14:54:05.000Z')

    get "/api/v1/transactions/find?created_at=#{transaction.created_at.to_s}"

    expect(response).to be_successful

    transaction = JSON.parse(response.body)['data']

    expect(transaction['attributes'].keys).to include('id')
    expect(transaction['attributes'].keys).to include('invoice_id')
    expect(transaction['attributes'].keys).to include('credit_card_number')
    expect(transaction['attributes'].keys).to include('result')
    expect(transaction['attributes'].keys).to_not include('created_at')
    expect(transaction['attributes'].keys).to_not include('updated_at')
   end

  it "transaction find request: UPDATED AT" do
    transaction = create(:transaction, updated_at: '2012-03-28T14:54:05.000Z')

    get "/api/v1/transactions/find?updated_at=#{transaction.updated_at.to_s}"

    expect(response).to be_successful

    transaction = JSON.parse(response.body)['data']

    expect(transaction['attributes'].keys).to include('id')
    expect(transaction['attributes'].keys).to include('invoice_id')
    expect(transaction['attributes'].keys).to include('credit_card_number')
    expect(transaction['attributes'].keys).to include('result')
    expect(transaction['attributes'].keys).to_not include('created_at')
    expect(transaction['attributes'].keys).to_not include('updated_at')
   end

   it "transaction find_all request: ID" do
     transaction = create(:transaction)

     get "/api/v1/transactions/find_all?id=#{transaction.id}"

     expect(response).to be_successful

     transaction = JSON.parse(response.body)['data']

     expect(transaction.class).to eq(Array)
     expect(transaction.length).to eq(1)

     transaction = transaction.first
     expect(transaction['attributes'].keys).to include('id')
     expect(transaction['attributes'].keys).to include('invoice_id')
     expect(transaction['attributes'].keys).to include('credit_card_number')
     expect(transaction['attributes'].keys).to include('result')
     expect(transaction['attributes'].keys).to_not include('created_at')
     expect(transaction['attributes'].keys).to_not include('updated_at')
    end

   it "transaction find_all request: merchant_id" do
     merchant = create(:merchant)
     merchant_1 = create(:merchant)
     transaction = create(:transaction, merchant_id: merchant.id)
     create(:transaction, merchant_id: merchant.id)
     create(:transaction, merchant_id: merchant_1.id)

     get "/api/v1/transactions/find_all?merchant_id=#{merchant.id}"

     expect(response).to be_successful

     transaction = JSON.parse(response.body)['data']

     expect(transaction.class).to eq(Array)
     expect(transaction.length).to eq(2)

     transaction = transaction.first
     expect(transaction['attributes'].keys).to include('id')
     expect(transaction['attributes'].keys).to include('invoice_id')
     expect(transaction['attributes'].keys).to include('credit_card_number')
     expect(transaction['attributes'].keys).to include('result')
     expect(transaction['attributes'].keys).to_not include('created_at')
     expect(transaction['attributes'].keys).to_not include('updated_at')
    end

   it "transaction find_all request: customer_id" do
     customer = create(:customer)
     customer_1 = create(:customer)
     transaction = create(:transaction, customer_id: customer.id)
     create(:transaction, customer_id: customer.id)
     create(:transaction, customer_id: customer_1.id)

     get "/api/v1/transactions/find_all?customer_id=#{transaction.customer_id}"

     expect(response).to be_successful

     transaction = JSON.parse(response.body)['data']

     expect(transaction.class).to eq(Array)
     expect(transaction.length).to eq(2)

     transaction = transaction.first
     expect(transaction['attributes'].keys).to include('id')
     expect(transaction['attributes'].keys).to include('invoice_id')
     expect(transaction['attributes'].keys).to include('credit_card_number')
     expect(transaction['attributes'].keys).to include('result')
     expect(transaction['attributes'].keys).to_not include('created_at')
     expect(transaction['attributes'].keys).to_not include('updated_at')
    end

   it "transaction find_all request: status" do
     transaction = create(:transaction, status: "hello")
     create(:transaction, status: "hello")
     create(:transaction, status: "pending")

     get "/api/v1/transactions/find_all?status=#{transaction.status}"

     expect(response).to be_successful

     transaction = JSON.parse(response.body)['data']

     expect(transaction.class).to eq(Array)
     expect(transaction.length).to eq(2)

     transaction = transaction.first
     expect(transaction['attributes'].keys).to include('id')
     expect(transaction['attributes'].keys).to include('invoice_id')
     expect(transaction['attributes'].keys).to include('credit_card_number')
     expect(transaction['attributes'].keys).to include('result')
     expect(transaction['attributes'].keys).to_not include('created_at')
     expect(transaction['attributes'].keys).to_not include('updated_at')
    end


   it "transaction find_all request: CREATED AT" do
     transaction = create(:transaction, created_at: '2012-03-28T14:54:05.000Z')
     create(:transaction, created_at: '2012-03-28T14:54:05.000Z')
     create(:transaction, created_at: '2012-03-29T14:54:05.000Z')

     get "/api/v1/transactions/find_all?created_at='2012-03-28T14:54:05.000Z'"

     expect(response).to be_successful

     transaction = JSON.parse(response.body)['data']

     expect(transaction.class).to eq(Array)
     expect(transaction.length).to eq(2)
    end

   it "transaction find_all request: UPDATED AT" do
     transaction = create(:transaction, updated_at: '2012-03-28T14:54:05.000Z')
     create(:transaction, updated_at: '2012-03-28T14:54:05.000Z')
     create(:transaction, updated_at: '2012-03-29T14:54:05.000Z')

     get "/api/v1/transactions/find_all?updated_at='2012-03-28T14:54:05.000Z'"

     expect(response).to be_successful

     transaction = JSON.parse(response.body)['data']

     expect(transaction.class).to eq(Array)
     expect(transaction.length).to eq(2)
    end

  it "random mechant" do
    create_list(:transaction, 100)

    get "/api/v1/transactions/random"

    expect(response).to be_successful
    transaction = JSON.parse(response.body)['data']

    id = transaction['attributes']['id']

    expect(transaction['attributes'].keys).to include('id')
    expect(transaction['attributes'].keys).to include('invoice_id')
    expect(transaction['attributes'].keys).to include('credit_card_number')
    expect(transaction['attributes'].keys).to include('result')
    expect(transaction['attributes'].keys).to_not include('created_at')
    expect(transaction['attributes'].keys).to_not include('updated_at')

    get "/api/v1/transactions/random"

    expect(response).to be_successful
    transaction = JSON.parse(response.body)['data']

    expect(transaction['attributes']['id']).to_not eq(id)
  end

 end
