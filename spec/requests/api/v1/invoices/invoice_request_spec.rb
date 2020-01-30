require 'rails_helper'

describe "invoice API" do
  it "sends a list of invoices" do
    create_list(:invoice, 3)

    get '/api/v1/invoices'

    expect(response).to be_successful

    invoices = JSON.parse(response.body)['data']
    expect(invoices.count).to eq(3)
   end

  it "invoice show request" do
    invoice = create(:invoice)

    get "/api/v1/invoices/#{invoice.id}"

    expect(response).to be_successful

    invoice = JSON.parse(response.body)['data']

    expect(invoice['attributes'].keys).to include('id')
    expect(invoice['attributes'].keys).to include('merchant_id')
    expect(invoice['attributes'].keys).to include('customer_id')
    expect(invoice['attributes'].keys).to include('status')
    expect(invoice['attributes'].keys).to_not include('created_at')
    expect(invoice['attributes'].keys).to_not include('updated_at')
   end

  it "invoice find request: ID" do
    invoice = create(:invoice)

    get "/api/v1/invoices/find?id=#{invoice.id}"

    expect(response).to be_successful

    invoice = JSON.parse(response.body)['data']

    expect(invoice['attributes'].keys).to include('id')
    expect(invoice['attributes'].keys).to include('merchant_id')
    expect(invoice['attributes'].keys).to include('customer_id')
    expect(invoice['attributes'].keys).to include('status')
    expect(invoice['attributes'].keys).to_not include('created_at')
    expect(invoice['attributes'].keys).to_not include('updated_at')
   end

  it "invoice find request: customer_id" do
    invoice = create(:invoice)

    get "/api/v1/invoices/find?customer_id=#{invoice.customer_id}"

    expect(response).to be_successful

    invoice = JSON.parse(response.body)['data']

    expect(invoice['attributes'].keys).to include('id')
    expect(invoice['attributes'].keys).to include('merchant_id')
    expect(invoice['attributes'].keys).to include('customer_id')
    expect(invoice['attributes'].keys).to include('status')
    expect(invoice['attributes'].keys).to_not include('created_at')
    expect(invoice['attributes'].keys).to_not include('updated_at')
   end

  it "invoice find request: merchant_id" do
    invoice = create(:invoice)

    get "/api/v1/invoices/find?merchant_id=#{invoice.merchant_id}"

    expect(response).to be_successful

    invoice = JSON.parse(response.body)['data']

    expect(invoice['attributes'].keys).to include('id')
    expect(invoice['attributes'].keys).to include('merchant_id')
    expect(invoice['attributes'].keys).to include('customer_id')
    expect(invoice['attributes'].keys).to include('status')
    expect(invoice['attributes'].keys).to_not include('created_at')
    expect(invoice['attributes'].keys).to_not include('updated_at')
   end

  it "invoice find request: status" do
    invoice = create(:invoice, status: 'happy')

    get "/api/v1/invoices/find?status=#{invoice.status}"

    expect(response).to be_successful

    invoice = JSON.parse(response.body)['data']

    expect(invoice['attributes'].keys).to include('id')
    expect(invoice['attributes'].keys).to include('merchant_id')
    expect(invoice['attributes'].keys).to include('customer_id')
    expect(invoice['attributes'].keys).to include('status')
    expect(invoice['attributes'].keys).to_not include('created_at')
    expect(invoice['attributes'].keys).to_not include('updated_at')
   end

  it "invoice find request: CREATED AT" do
    invoice = create(:invoice, created_at: '2012-03-28T14:54:05.000Z')

    get "/api/v1/invoices/find?created_at=#{invoice.created_at.to_s}"

    expect(response).to be_successful

    invoice = JSON.parse(response.body)['data']

    expect(invoice['attributes'].keys).to include('id')
    expect(invoice['attributes'].keys).to include('merchant_id')
    expect(invoice['attributes'].keys).to include('customer_id')
    expect(invoice['attributes'].keys).to include('status')
    expect(invoice['attributes'].keys).to_not include('created_at')
    expect(invoice['attributes'].keys).to_not include('updated_at')
   end

  it "invoice find request: UPDATED AT" do
    invoice = create(:invoice, updated_at: '2012-03-28T14:54:05.000Z')

    get "/api/v1/invoices/find?updated_at=#{invoice.updated_at.to_s}"

    expect(response).to be_successful

    invoice = JSON.parse(response.body)['data']

    expect(invoice['attributes'].keys).to include('id')
    expect(invoice['attributes'].keys).to include('merchant_id')
    expect(invoice['attributes'].keys).to include('customer_id')
    expect(invoice['attributes'].keys).to include('status')
    expect(invoice['attributes'].keys).to_not include('created_at')
    expect(invoice['attributes'].keys).to_not include('updated_at')
   end

   it "invoice find_all request: ID" do
     invoice = create(:invoice)

     get "/api/v1/invoices/find_all?id=#{invoice.id}"

     expect(response).to be_successful

     invoice = JSON.parse(response.body)['data']

     expect(invoice.class).to eq(Array)
     expect(invoice.length).to eq(1)

     invoice = invoice.first
     expect(invoice['attributes'].keys).to include('id')
     expect(invoice['attributes'].keys).to include('merchant_id')
     expect(invoice['attributes'].keys).to include('customer_id')
     expect(invoice['attributes'].keys).to include('status')
     expect(invoice['attributes'].keys).to_not include('created_at')
     expect(invoice['attributes'].keys).to_not include('updated_at')
    end

   it "invoice find_all request: merchant_id" do
     merchant = create(:merchant)
     merchant_1 = create(:merchant)
     invoice = create(:invoice, merchant_id: merchant.id)
     create(:invoice, merchant_id: merchant.id)
     create(:invoice, merchant_id: merchant_1.id)

     get "/api/v1/invoices/find_all?merchant_id=#{merchant.id}"

     expect(response).to be_successful

     invoice = JSON.parse(response.body)['data']

     expect(invoice.class).to eq(Array)
     expect(invoice.length).to eq(2)

     invoice = invoice.first
     expect(invoice['attributes'].keys).to include('id')
     expect(invoice['attributes'].keys).to include('merchant_id')
     expect(invoice['attributes'].keys).to include('customer_id')
     expect(invoice['attributes'].keys).to include('status')
     expect(invoice['attributes'].keys).to_not include('created_at')
     expect(invoice['attributes'].keys).to_not include('updated_at')
    end

   it "invoice find_all request: customer_id" do
     customer = create(:customer)
     customer_1 = create(:customer)
     invoice = create(:invoice, customer_id: customer.id)
     create(:invoice, customer_id: customer.id)
     create(:invoice, customer_id: customer_1.id)

     get "/api/v1/invoices/find_all?customer_id=#{invoice.customer_id}"

     expect(response).to be_successful

     invoice = JSON.parse(response.body)['data']

     expect(invoice.class).to eq(Array)
     expect(invoice.length).to eq(2)

     invoice = invoice.first
     expect(invoice['attributes'].keys).to include('id')
     expect(invoice['attributes'].keys).to include('merchant_id')
     expect(invoice['attributes'].keys).to include('customer_id')
     expect(invoice['attributes'].keys).to include('status')
     expect(invoice['attributes'].keys).to_not include('created_at')
     expect(invoice['attributes'].keys).to_not include('updated_at')
    end

   it "invoice find_all request: status" do
     invoice = create(:invoice, status: "hello")
     create(:invoice, status: "hello")
     create(:invoice, status: "pending")

     get "/api/v1/invoices/find_all?status=#{invoice.status}"

     expect(response).to be_successful

     invoice = JSON.parse(response.body)['data']

     expect(invoice.class).to eq(Array)
     expect(invoice.length).to eq(2)

     invoice = invoice.first
     expect(invoice['attributes'].keys).to include('id')
     expect(invoice['attributes'].keys).to include('merchant_id')
     expect(invoice['attributes'].keys).to include('customer_id')
     expect(invoice['attributes'].keys).to include('status')
     expect(invoice['attributes'].keys).to_not include('created_at')
     expect(invoice['attributes'].keys).to_not include('updated_at')
    end


   it "invoice find_all request: CREATED AT" do
     invoice = create(:invoice, created_at: '2012-03-28T14:54:05.000Z')
     create(:invoice, created_at: '2012-03-28T14:54:05.000Z')
     create(:invoice, created_at: '2012-03-29T14:54:05.000Z')

     get "/api/v1/invoices/find_all?created_at='2012-03-28T14:54:05.000Z'"

     expect(response).to be_successful

     invoice = JSON.parse(response.body)['data']

     expect(invoice.class).to eq(Array)
     expect(invoice.length).to eq(2)
    end

   it "invoice find_all request: UPDATED AT" do
     invoice = create(:invoice, updated_at: '2012-03-28T14:54:05.000Z')
     create(:invoice, updated_at: '2012-03-28T14:54:05.000Z')
     create(:invoice, updated_at: '2012-03-29T14:54:05.000Z')

     get "/api/v1/invoices/find_all?updated_at='2012-03-28T14:54:05.000Z'"

     expect(response).to be_successful

     invoice = JSON.parse(response.body)['data']

     expect(invoice.class).to eq(Array)
     expect(invoice.length).to eq(2)
    end

  it "random mechant" do
    create_list(:invoice, 100)

    get "/api/v1/invoices/random"

    expect(response).to be_successful
    invoice = JSON.parse(response.body)['data']

    id = invoice['attributes']['id']

    expect(invoice['attributes'].keys).to include('id')
    expect(invoice['attributes'].keys).to include('merchant_id')
    expect(invoice['attributes'].keys).to include('customer_id')
    expect(invoice['attributes'].keys).to include('status')
    expect(invoice['attributes'].keys).to_not include('created_at')
    expect(invoice['attributes'].keys).to_not include('updated_at')

    get "/api/v1/invoices/random"

    expect(response).to be_successful
    invoice = JSON.parse(response.body)['data']

    expect(invoice['attributes']['id']).to_not eq(id)
  end

 end
