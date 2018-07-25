class InvoiceItem

  attr_accessor :id,
                :item_id,
                :invoice_id,
                :quantity,
                :created_at,
                :updated_at
  attr_writer   :unit_price

  def initialize(attributes)
    @id         = attributes[:id]
    @item_id    = attributes[:item_id]
    @invoice_id = attributes[:invoice_id]
    @quantity   = attributes[:quantity]
    @unit_price = attributes[:unit_price]
    @created_at = attributes[:created_at]
    @updated_at = attributes[:updated_at]
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end
end
