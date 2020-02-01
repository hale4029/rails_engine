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
      #self.all.sample
    elsif params[:slug] == "revenue"
      self.revenue(params)
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
    else
      "Query param error"
    end
  end

  def self.find_all_query(params)
    params.delete('slug')
    param = params.keys.first
    if (params.keys & ['name', 'id']).any?
      self.where(param => params[param])
    elsif (params.keys & ['created_at', 'updated_at']).any?
      self.where(param => params[param]).order("#{param} desc")
    else
      "Query param error"
    end
  end

  def self.revenue(params)
    date = Time.zone.parse(params['date'])
    result = Invoice.joins(:invoice_items).joins(:transactions).select('sum(invoice_items.quantity * invoice_items.unit_price) as total_revenue').where(invoices: {created_at: date.all_day}).where(transactions: {result: 'success'}).order('total_revenue')
    revenue = (result.first.total_revenue.to_f / 100)
    {data: {type: 'query_result', attributes: {total_revenue: revenue.to_s}}}
  end

end
