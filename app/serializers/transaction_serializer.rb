class TransactionSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :invoice_id, :credit_card_number, :result


  attribute :credit_card_number do |transactions|
    transactions.credit_card_number.to_s
  end

end
