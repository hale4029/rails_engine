class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices

  validates_presence_of :name


  def self.find_merchant(params)
    if params[:id] == "find"
      self.find_query(params)
    elsif params[:id] == "find_all"
      self.find_all_query(params)
    elsif params[:id] == "random"
      offset = rand(self.count)
      self.offset(offset).limit(1).first
      self.all.sample
    elsif params[:id] == "revenue"
      self.revenue(params)
    else
      self.find(params['id'])
    end
  end

  def self.find_query(params)
    if params.keys.include?('name')
      self.where(name: params['name']).first
    elsif params.keys.include?('merchant_id')
      self.find(params['merchant_id'])
    elsif params.keys.include?('created_at')
      self.where(created_at: Time.zone.parse(params['created_at']).all_day).first
    elsif params.keys.include?('updated_at')
      self.where(updated_at: Time.zone.parse(params['updated_at']).all_day).first
    else
      "Query param error"
    end
  end

  def self.find_all_query(params)
    if params.keys.include?('name')
      self.where(name: params['name'])
    elsif params.keys.include?('merchant_id')
      self.where(id: params['merchant_id'])
    elsif params.keys.include?('created_at')
      self.where(created_at: Time.zone.parse(params['created_at']).all_day)
    elsif params.keys.include?('updated_at')
      self.where(updated_at: Time.zone.parse(params['updated_at']).all_day)
    else
      "Query param error"
    end
  end

  def self.revenue(params)
    date = Time.zone.parse(params['date'])
    require "pry"; binding.pry
    result = InvoiceItem.select('sum(invoice_items.quantity * invoice_items.unit_price) as total_revenue').where(created_at: date.all_day)
    result.first.total_revenue
  end

end
