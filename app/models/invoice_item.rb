class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice


  validates_presence_of :item_id,
                        :invoice_id,
                        :quantity,
                        :unit_price

  def self.find_resource(params)
    if params.keys.include?('invoice_id')
      Invoice.find(params['invoice_id'])
    else
      "Query param error"
    end
  end
end
