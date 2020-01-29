class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  validates_presence_of :name,
                        :description,
                        :unit_price,
                        :merchant_id

  def self.find_resource(params)
    if params.keys.include?('merchant_id')
      Merchant.find(params['merchant_id'])
    elsif params.keys.include?('invoice_id')
      Invoice.find(params['invoice_id'])
    elsif params.keys.include?('invoice_item_id')
      InvoiceItem.find(params['invoice_item_id'])
    else
      "Query param error"
    end
  end

end
