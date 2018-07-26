class Transaction

  attr_accessor :id,
                :invoice_id,
                :credit_card_number,
                :credit_card_expiration_date,
                :result,
                :created_at,
                :updated_at

  def initialize(attributes)
    @id                          = attributes[:id].to_i
    @invoice_id                  = attributes[:invoice_id].to_i
    @credit_card_number          = attributes[:credit_card_number].to_s
    @credit_card_expiration_date = attributes[:credit_card_expiration_date]
    @result                      = attributes[:result].to_sym
    @created_at  = if attributes[:created_at].class == String
                     Time.parse(attributes[:created_at])
                   else
                     Time.now
                   end
    @updated_at  = if attributes[:updated_at].class == String
                     Time.parse(attributes[:updated_at])
                   else
                     Time.now
                   end
  end
end
