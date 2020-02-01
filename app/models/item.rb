class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  validates_presence_of :name,
                        :description,
                        :unit_price,
                        :merchant_id

  def self.find_resource(params)
    if params.keys.include?('merchant_slug')
      Merchant.find(params['merchant_slug'])
    elsif params.keys.include?('invoice_slug')
      Invoice.find(params['invoice_slug'])
    elsif params.keys.include?('invoice_item_slug')
      InvoiceItem.find(params['invoice_item_slug'])
    else
      "Query param error"
    end
  end

  def self.find_item(params)
    if params[:slug] == "find"
      self.find_query(params)
    elsif params[:slug] == "find_all"
      self.find_all_query(params)
    elsif params[:slug] == "random"
      offset = rand(self.count)
      self.offset(offset).limit(1).first
      #self.all.sample
    else
      self.find(params['slug'])
    end
  end

  def self.find_query(params)
    params.delete('slug')
    param = params.keys.first
    if (params.keys & ['id', 'name', 'description', 'merchant_id']).any?
      self.where(param => params[param])[0]
    elsif (params.keys & ['unit_price']).any?
      integer = (params[param].to_f * 100).round(2).to_i
      self.where(param => integer)[0]
    elsif (params.keys & ['created_at', 'updated_at']).any?
      self.where(param => params[param]).order("#{param} desc").first
    else
      "Query param error"
    end
  end

  def self.find_all_query(params)
    params.delete('slug')
    param = params.keys.first
    if (params.keys & ['id', 'name', 'description', 'merchant_id']).any?
      self.where(param => params[param]).order('id asc')
    elsif (params.keys & ['unit_price']).any?
      integer = (params[param].to_f * 100).round(2).to_i
      self.where(param => integer)
    elsif (params.keys & ['created_at', 'updated_at']).any?
      self.where(param => params[param]).order("#{param} desc")
    else
      "Query param error"
    end
  end

  def self.most_revenue(quantity)
    Item.joins(invoices: [:invoice_items, :transactions]).select('items.*, sum(invoice_items.quantity * invoice_items.unit_price) as sales').group(:id).where(transactions: {result: 'success'}).order('sales desc').limit(quantity)
  end

end
