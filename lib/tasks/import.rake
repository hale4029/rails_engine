require 'CSV'

namespace :import do

  task customers: :environment do
    #require "pry"; binding.pry
    filename = '/Users/hlevin/turing/mod_3/rails_engine_project/rails_engine_api/data/customers.csv'
    counter = 0

    CSV.foreach(filename, headers: true) do |row|
      customer = Customer.create(id: row['id'],first_name: row['first_name'], last_name: row['last_name'], created_at: row['created_at'], updated_at: row['updated_at'])
      counter += 1 if customer.persisted?
    end

    puts "Imported #{counter} customers."
  end
end
