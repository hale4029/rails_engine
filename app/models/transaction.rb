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
end
