require 'CSV'

namespace :import do

  task customers: :environment do
    filename = '/Users/hlevin/turing/mod_3/rails_engine_project/rails_engine_api/data/customers.csv'
    counter = 0

    CSV.foreach(filename, headers: true) do |row|
      customer = Customer.create(id: row['id'], first_name: row['first_name'], last_name: row['last_name'], created_at: row['created_at'], updated_at: row['updated_at'])
      counter += 1 if customer.persisted?
    end

    puts "Imported #{counter} customers."
  end

  task merchants: :environment do
    filename = '/Users/hlevin/turing/mod_3/rails_engine_project/rails_engine_api/data/merchants.csv'
    counter = 0

    CSV.foreach(filename, headers: true) do |row|
      merchant = Merchant.create(id: row['id'], name: row['name'], created_at: row['created_at'], updated_at: row['updated_at'])
      counter += 1 if merchant.persisted?
    end

    puts "Imported #{counter} merchants."
  end

  task items: :environment do
    filename = '/Users/hlevin/turing/mod_3/rails_engine_project/rails_engine_api/data/items.csv'
    counter = 0

    CSV.foreach(filename, headers: true) do |row|
      item = Item.create(id: row['id'], name: row['name'], description: row['description'], unit_price: row['unit_price'], merchant_id: row['merchant_id'], created_at: row['created_at'], updated_at: row['updated_at'])
      counter += 1 if item.persisted?
    end

    puts "Imported #{counter} items."
  end

  task invoices: :environment do
    filename = '/Users/hlevin/turing/mod_3/rails_engine_project/rails_engine_api/data/invoices.csv'
    counter = 0

    CSV.foreach(filename, headers: true) do |row|
      invoice = Invoice.create(id: row['id'], customer_id: row['customer_id'], merchant_id: row['merchant_id'], status: row['status'], created_at: row['created_at'], updated_at: row['updated_at'])
      counter += 1 if invoice.persisted?
    end

    puts "Imported #{counter} invoices."
  end

  task invoice_items: :environment do
    filename = '/Users/hlevin/turing/mod_3/rails_engine_project/rails_engine_api/data/invoice_items.csv'
    counter = 0

    CSV.foreach(filename, headers: true) do |row|
      invoice_item = InvoiceItem.create(id: row['id'], item_id: row['item_id'], invoice_id: row['invoice_id'], quantity: row['quantity'], unit_price: row['unit_price'], created_at: row['created_at'], updated_at: row['updated_at'])
      counter += 1 if invoice_item.persisted?
    end

    puts "Imported #{counter} invoice_items."
  end

end
