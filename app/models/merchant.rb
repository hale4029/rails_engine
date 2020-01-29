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
      self.all.sample
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
      # self.where(name: params['name']).first
      self.where(param => params[param])[0]
    # elsif params.keys.include?('id')
    #   self.find(params['id'])
    elsif (params.keys & ['created_at', 'updated_at']).any?
      #self.where(created_at: Time.zone.parse(params['created_at']).all_day).order('created_at desc').first
      #self.where(created_at: params['created_at']).order('created_at desc').first
      self.where(param => params[param]).order("#{param} desc").first
  #  elsif params.keys.include?('updated_at')
      #self.where(updated_at: Time.zone.parse(params['updated_at']).all_day).order('updated_at desc').first
      #self.where(updated_at: params['updated_at']).order('updated_at desc').first
    else
      "Query param error"
    end
  end

  def self.find_all_query(params)
    params.delete('slug')
    param = params.keys.first
    if (params.keys & ['name', 'id']).any?
      self.where(param => params[param])
      #self.where(name: params['name'])
    # elsif params.keys.include?('id')
    #   self.where(id: params['id'])
    elsif (params.keys & ['created_at', 'updated_at']).any?
      self.where(param => params[param]).order("#{param} desc")
      #self.where(created_at: Time.zone.parse(params['created_at']).all_day).order('created_at desc')
    #   self.where(created_at: params['created_at']).order('created_at desc')
    # elsif params.keys.include?('updated_at')
    #   #self.where(updated_at: Time.zone.parse(params['updated_at']).all_day).order('updated_at desc')
    #   self.where(updated_at: params['updated_at']).order('updated_at desc')
    else
      "Query param error"
    end
  end

  def self.revenue(params)
    date = Time.zone.parse(params['date'])
    result = InvoiceItem.select('sum(invoice_items.quantity * invoice_items.unit_price) as total_revenue').where(created_at: date.all_day).order('total_revenue')
    result.first.total_revenue
  end

end
