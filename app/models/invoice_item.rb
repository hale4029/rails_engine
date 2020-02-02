class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice


  validates_presence_of :item_id,
                        :invoice_id,
                        :quantity,
                        :unit_price

  def self.find_invoice_item(params)
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
    if (params.keys & ['id', 'item_id', 'invoice_id', 'quantity']).any?
      self.where(param => params[param])[0]
    elsif (params.keys & ['unit_price']).any?
      integer = (params[param].to_f * 100).to_i
      self.where(param => integer)[0]
    elsif (params.keys & ['created_at', 'updated_at']).any?
      self.where(param => params[param]).order("#{param} desc").first
    end
  end

  def self.find_all_query(params)
    params.delete('slug')
    param = params.keys.first
    if (params.keys & ['id', 'item_id', 'invoice_id', 'quantity']).any?
      self.where(param => params[param]).order('id asc')
    elsif (params.keys & ['unit_price']).any?
      integer = (params[param].to_f * 100).to_i
      self.where(param => integer)
    elsif (params.keys & ['created_at', 'updated_at']).any?
      self.where(param => params[param]).order("#{param} desc")
    end
  end

end
