class InvoiceItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :item_id, :invoice_id, :quantity, :unit_price

  attribute :unit_price do |invoice_items|
    (invoice_items.unit_price.to_f / 100).to_s
  end

end
