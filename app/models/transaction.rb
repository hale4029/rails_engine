class Transaction < ApplicationRecord
  belongs_to :invoice

  validates_presence_of :invoice_id,
                        :credit_card_number,
                        #:credit_card_expiration_date,
                        :result

  def self.find_resource(params)
    if params.keys.include?('invoice_id')
      Invoice.find(params['invoice_id'])
    else
      "Query param error"
    end
  end

  def self.find_transaction(params)
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
    if (params.keys & ['id', 'invoice_id', 'credit_card_number', 'result']).any?
      self.where(param => params[param])[0]
    elsif (params.keys & ['created_at', 'updated_at']).any?
      self.where(param => params[param]).order("#{param} desc").first
    end
  end

  def self.find_all_query(params)
    params.delete('slug')
    param = params.keys.first
    if (params.keys & ['id', 'invoice_id', 'credit_card_number', 'result']).any?
      self.where(param => params[param]).order('id asc')
    elsif (params.keys & ['created_at', 'updated_at']).any?
      self.where(param => params[param]).order("#{param} desc")
    end
  end
end
