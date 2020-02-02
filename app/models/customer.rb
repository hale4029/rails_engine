class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices


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
    end
  end

  def self.find_all_query(params)
    params.delete('slug')
    param = params.keys.first
    if (params.keys & ['first_name', 'last_name', 'id']).any?
      self.where(param => params[param])
    elsif (params.keys & ['created_at', 'updated_at']).any?
      self.where(param => params[param]).order("#{param} desc")
    end
  end

  def customer_transactions
    Transaction.joins(customers: [:invoices]).where("invoices.customer_id == #{self.id}")
  end

  def favorite_merchant
    Merchant.joins(invoices: [:transactions]).select('merchants.*, count(transactions.*) as total_transactions').group('merchants.id').where(invoices: {customer_id: self.id}).where(transactions: {result: 'success'}).order('total_transactions desc').limit(1)[0]
  end

end
