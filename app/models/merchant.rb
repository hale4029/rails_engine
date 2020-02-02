class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices

  validates_presence_of :name


  def self.find_merchant(params)
    if params[:slug] == "find"
      self.find_query(params)
    elsif params[:slug] == "find_all"
      self.find_all_query(params)
    elsif params[:slug] == "random"
      offset = rand(self.count)
      self.offset(offset).limit(1).first
    elsif params[:slug] == "revenue"
      self.revenue(params)
    elsif params[:slug] == "most_revenue"
      self.most_revenue(params)
    else
      self.find(params['slug'])
    end
  end

  def self.find_query(params)
    params.delete('slug')
    param = params.keys.first
    if (params.keys & ['name', 'id']).any?
      self.where(param => params[param])[0]
    elsif (params.keys & ['created_at', 'updated_at']).any?
      self.where(param => params[param]).order("#{param} desc").first
    end
  end

  def self.find_all_query(params)
    params.delete('slug')
    param = params.keys.first
    if (params.keys & ['name', 'id']).any?
      self.where(param => params[param])
    elsif (params.keys & ['created_at', 'updated_at']).any?
      self.where(param => params[param]).order("#{param} desc")
    end
  end

  def self.revenue(params)
    date = Time.zone.parse(params['date'])
    result = Invoice.joins(:invoice_items).joins(:transactions).select('sum(invoice_items.quantity * invoice_items.unit_price) as total_revenue').where(invoices: {created_at: date.all_day}).where(transactions: {result: 'success'}).order('total_revenue')
    revenue = (result.first.total_revenue.to_f / 100)
    {data: {type: 'query_result', attributes: {total_revenue: revenue.to_s}}}
  end

  def self.most_revenue(params)
    self.joins(invoices: [:invoice_items, :transactions]).select('merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) as total_revenue').group(:id).where(transactions: {result: 'success'}).order('total_revenue desc').limit(params[:quantity])
  end

  def revenue
    result = Merchant.joins(invoices: [:invoice_items, :transactions]).select('merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) as total_revenue').group(:id).where(merchants: {id: self.id}).where(transactions: {result: 'success'}).order('total_revenue')[0]
    revenue = (result.total_revenue.to_f / 100)
    {data: {type: 'query_result', attributes: {revenue: revenue.to_s}}}
  end

  def favorite_customer
    Customer.joins(invoices: :transactions).select("customers.*, count(transactions.id) as total_transactions").where("transactions.result = 'success' AND invoices.merchant_id = #{self.id}").group(:id).order('total_transactions DESC').limit(1)[0]
  end

end
