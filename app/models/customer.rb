class Customer < ApplicationRecord
  has_many :invoices

  validates_presence_of :first_name,
                        :last_name

  def self.find_customer(params)
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
    if (params.keys & ['first_name', 'last_name', 'id']).any?
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
    if (params.keys & ['first_name', 'last_name', 'id']).any?
      self.where(param => params[param])
    elsif (params.keys & ['created_at', 'updated_at']).any?
      self.where(param => params[param]).order("#{param} desc")
    else
      "Query param error"
    end
  end

  def customer_transactions
    Transaction.joins(customers: [:invoices]).where("invoices.customer_id == #{self.id}")
  end
end
