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

end
