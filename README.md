# README

This repo uses ROR and ActiveRecord to build a JSON API which exposes a SalesEngine data schema. The complete set of directions can be found at https://backend.turing.io/module3/projects/rails_engine_modified.

Setup Instructions:

 - `mkdir` (new directory)
 - `git clone git@github.com:turingschool/rales_engine_spec_harness.git`
 - `git clone git@github.com:hale4029/rails_engine.git`
   - This spec-harness tests relationships, endpoints, and biz logic queries
 - Ruby version: 2.5.3
 - `bundle install and update`
 - `db:{drop,create,migrate}`
 - `rake import:customers`
 - `rake import:merchants`
 - `rake import:items`
 - `rake import:invoices`
 - `rake import:transactions`
 - `rake import:invoice_items`
 - run `rspec` for test coverage
    - /coverage open index.html (simplecov gem)
 
 ## Access Endpoints

These endpoints can be accessed locally from your computer. Responses are rendered in JSON with FastAPI serializers.

Start a local server:

`rails s`


Then open a browser and enter "localhost:3000".

### Merchant Endpoints

  `GET` /api/1/merchants<br/>
  `GET` /api/1/merchants/:id<br/>
  `GET` /api/1/merchants/:id/items<br/>
  `GET` /api/1/merchants/:id/invoices<br/>
  `GET` /api/1/merchants/find<br/>
  `GET` /api/1/merchants/find_all<br/>
  `GET` /api/1/merchants/random<br/>
  `GET` /api/1/merchants/most_revenue<br/>
  `GET` /api/1/merchants/revenue<br/>

  ### Customers Endpoints

  `GET` /api/1/customers<br/>
  `GET` /api/1/customers/:id<br/>
  `GET` /api/1/customers/:id/invoices<br/>
  `GET` /api/1/customers/:id/transactions<br/>
  `GET` /api/1/customers/random<br/>
  `GET` /api/1/customers/find<br/>
  `GET` /api/1/customers/find_all<br/>

  ### Items Endpoints

  `GET` /api/1/items<br/>
  `GET` /api/1/items/:id<br/>
  `GET` /api/1/items/:id/invoice_items<br/>
  `GET` /api/1/items/:id/merchant<br/>
  `GET` /api/1/items/random<br/>
  `GET` /api/1/items/find<br/>
  `GET` /api/1/items/find_all<br/>

  ### Invoice Items Endpoints

  `GET` /api/1/invoice_items<br/>
  `GET` /api/1/invoice_items/:id<br/>
  `GET` /api/1/invoice_items/:id/invoice<br/>
  `GET` /api/1/invoice_items/:id/item<br/>
  `GET` /api/1/invoice_items/random<br/>
  `GET` /api/1/invoice_items/find<br/>
  `GET` /api/1/invoice_items/find_all<br/>

  ### Invoices Endpoints

  `GET` /api/1/invoices<br/>
  `GET` /api/1/invoices/:id<br/>
  `GET` /api/1/invoices/:id/transactions<br/>
  `GET` /api/1/invoices/:id/invoice_items<br/>
  `GET` /api/1/invoices/:id/items<br/>
  `GET` /api/1/invoices/:id/customer<br/>
  `GET` /api/1/invoices/:id/merchant<br/>
  `GET` /api/1/invoices/random<br/>
  `GET` /api/1/invoices/find<br/>
  `GET` /api/1/invoices/find_all<br/>

  ### Transaction Endpoints

  `GET` /api/1/transactions<br/>
  `GET` /api/1/transactions/:id/invoice<br/>
  `GET` /api/1/transactions/find<br/>
  `GET` /api/1/transactions/random<br/>
  `GET` /api/1/transactions/find_all<br/>


  ### Business Intelligence Endpoints

   All Merchants
   `GET` /api/v1/merchants/most_revenue?quantity=x 
        - returns the top x merchants ranked by total revenue
   `GET` /api/v1/merchants/revenue?date=x 
        - returns the total revenue for date x across all merchants

   Single Merchant
   `GET` /api/v1/merchants/:id/favorite_customer 
        - returns the customer who has conducted the most total number of successful    transactions.

   Items
   `GET` /api/v1/items/most_revenue?quantity=x returns the top x items ranked by total revenue generated

   `GET` /api/v1/items/:id/best_day 
         - returns the date with the most sales for the given item using the invoice date. If there are multiple days with equal number of sales, return the most recent day.

   Customers
   `GET` /api/v1/customers/:id/favorite_merchant  
        - returns a merchant where the customer has conducted the most successful transactions

    
 
