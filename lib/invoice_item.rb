class InvoiceItem

  attr_accessor :id,
                :item_id,
                :invoice_id,
                :quantity,
                :created_at,
                :updated_at,
                :unit_price

  def initialize(attributes)
    @id         = attributes[:id].to_i
    @item_id    = attributes[:item_id].to_i
    @invoice_id = attributes[:invoice_id].to_i
    @quantity   = attributes[:quantity].to_i
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
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end
end
