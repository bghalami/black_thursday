require 'bigdecimal'
require 'bigdecimal/util'
require 'time'

class Item
  attr_accessor :name,
                :description,
                :unit_price,
                :updated_at,
                :created_at,
                :id

  attr_reader :merchant_id

  def initialize(attributes)
    @id          = attributes[:id].to_i
    @name        = attributes[:name]
    @description = attributes[:description]
    @unit_price  = if attributes[:unit_price].class == BigDecimal
                     attributes[:unit_price]
                   else
                     (attributes[:unit_price].to_i / 100.00).to_d
                   end
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
    @merchant_id = attributes[:merchant_id].to_i
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end
end
