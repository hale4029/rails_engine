class ResourceFinder
  def self.find_resource(params)
    if params.keys.include?('invoice_slug')
      Invoice.find(params['invoice_slug'])
    elsif params.keys.include?('invoice_item_slug')
      InvoiceItem.find(params['invoice_item_slug'])
    elsif params.keys.include?('transaction_slug')
      Transaction.find(params['transaction_slug'])
    elsif params.keys.include?('merchant_slug')
      Merchant.find(params['merchant_slug'])
    elsif params.keys.include?('item_slug')
      Item.find(params['item_slug'])
    elsif params.keys.include?('customer_slug')
      Customer.find(params['customer_slug'])
    end
  end
end
