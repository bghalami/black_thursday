require 'time'

class Invoice

  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at

  def initialize(attributes)
    @id          = attributes[:id].to_i
    @customer_id = attributes[:customer_id].to_i
    @merchant_id = attributes[:merchant_id].to_i
    @status      = attributes[:status]
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
