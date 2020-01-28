class Merchant < ApplicationRecord
  validates_presence_of :name

  def self.find_merchant(params)
    var = params[:id]
    if var == "find"
      if params.keys.include?('name')
        self.where(name: params['name']).first
      elsif params.keys.include?('merchant_id')
        self.find(params['merchant_id'])
      elsif params.keys.include?('created_at')
        self.where(created_at: Time.zone.parse(params['created_at']).all_day).first
      elsif params.keys.include?('updated_at')
        self.where(updated_at: Time.zone.parse(params['updated_at']).all_day).first
      else
        "Error"
      end
    else
      self.find(params['id'])
    end
  end
end
