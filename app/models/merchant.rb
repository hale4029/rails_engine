class Merchant < ApplicationRecord
  validates_presence_of :name

  def self.find_merchant(params)
    if params[:id] == "find"
      self.find_query(params)
    elsif params[:id] == "find_all"
      self.find_all_query(params)
    elsif params[:id] == "random"
      offset = rand(Merchant.count)
      Merchant.offset(offset).limit(1).first
      self.all.sample
    else
      self.find(params['id'])
    end
  end

  def self.find_query(params)
    if params.keys.include?('name')
      Merchant.where(name: params['name']).first
    elsif params.keys.include?('merchant_id')
      Merchant.find(params['merchant_id'])
    elsif params.keys.include?('created_at')
      Merchant.where(created_at: Time.zone.parse(params['created_at']).all_day).first
    elsif params.keys.include?('updated_at')
      Merchant.where(updated_at: Time.zone.parse(params['updated_at']).all_day).first
    else
      "Query param error"
    end
  end

  def self.find_all_query(params)
    if params.keys.include?('name')
      Merchant.where(name: params['name'])
    elsif params.keys.include?('merchant_id')
      Merchant.where(id: params['merchant_id'])
    elsif params.keys.include?('created_at')
      Merchant.where(created_at: Time.zone.parse(params['created_at']).all_day)
    elsif params.keys.include?('updated_at')
      Merchant.where(updated_at: Time.zone.parse(params['updated_at']).all_day)
    else
      "Query param error"
    end
  end

end
