require_relative '../test/test_helper.rb'
require_relative '../lib/invoice_item'

class InvoiceItemTest < Minitest::Test
  def setup
    @ii = InvoiceItem.new({
      :id => 6,
      :item_id => 7,
      :invoice_id => 8,
      :quantity => 1,
      :unit_price => BigDecimal.new(10.99, 4),
      :created_at => Time.now,
      :updated_at => Time.now
    })
  end

  def test_it_exists
    assert_instance_of InvoiceItem, @ii
  end

  def test_it_has_attributes
    assert_equal 6, @ii.id
    assert_equal 7, @ii.item_id
    assert_equal 8, @ii.invoice_id
    assert_equal 1, @ii.quantity
    assert_instance_of Time, @ii.created_at
    assert_instance_of Time, @ii.updated_at
  end

  def test_it_can_return_unit_price_as_float
    assert_equal 10.99, @ii.unit_price_to_dollars
  end
end
