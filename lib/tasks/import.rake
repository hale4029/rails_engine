require 'CSV'

namespace :import do

  task customers: :environment do
    filename = './data/customers.csv'
    counter = 0

    CSV.foreach(filename, headers: true) do |row|
      customer = Customer.create(id: row['id'], first_name: row['first_name'], last_name: row['last_name'], created_at: row['created_at'], updated_at: row['updated_at'])
      counter += 1 if customer.persisted?
    end

    puts "Imported #{counter} customers."
  end

  task merchants: :environment do
    filename = './data/merchants.csv'
    counter = 0

    CSV.foreach(filename, headers: true) do |row|
      merchant = Merchant.create(id: row['id'], name: row['name'], created_at: row['created_at'], updated_at: row['updated_at'])
      counter += 1 if merchant.persisted?
    end

    puts "Imported #{counter} merchants."
  end

  task items: :environment do
    filename = './data/items.csv'
    counter = 0

    CSV.foreach(filename, headers: true) do |row|
      item = Item.create(id: row['id'], name: row['name'], description: row['description'], unit_price: row['unit_price'], merchant_id: row['merchant_id'], created_at: row['created_at'], updated_at: row['updated_at'])
      counter += 1 if item.persisted?
    end

    puts "Imported #{counter} items."
  end

  task invoices: :environment do
    filename = './data/invoices.csv'
    counter = 0

    CSV.foreach(filename, headers: true) do |row|
      invoice = Invoice.create(id: row['id'], customer_id: row['customer_id'], merchant_id: row['merchant_id'], status: row['status'], created_at: row['created_at'], updated_at: row['updated_at'])
      counter += 1 if invoice.persisted?
    end

    puts "Imported #{counter} invoices."
  end

  task invoice_items: :environment do
    filename = './data/invoice_items.csv'
    counter = 0

    CSV.foreach(filename, headers: true) do |row|
      invoice_item = InvoiceItem.create(id: row['id'], item_id: row['item_id'], invoice_id: row['invoice_id'], quantity: row['quantity'], unit_price: row['unit_price'], created_at: row['created_at'], updated_at: row['updated_at'])
      counter += 1 if invoice_item.persisted?
    end

    puts "Imported #{counter} invoice_items."
  end

  task transactions: :environment do
    filename = './data/transactions.csv'
    counter = 0

    CSV.foreach(filename, headers: true) do |row|
      transaction = Transaction.create(id: row['id'], invoice_id: row['invoice_id'], credit_card_number: row['credit_card_number'], credit_card_expiration_date: row['credit_card_expiration_date'], result: row['result'], created_at: row['created_at'], updated_at: row['updated_at'])
      counter += 1 if transaction.persisted?
    end

    puts "Imported #{counter} transactions."
  end

end

##JOMAH
# task customer_csv: :environment do
#   customers = CSV.foreach("./data/customers.csv", headers: true, header_converters: :symbol)
#   customers.each do |row_data|
#     Customer.create(row_data.to_hash)
#   end
# end
