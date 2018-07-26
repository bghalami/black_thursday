require_relative '../test/test_helper.rb'
require_relative '../lib/invoice_item_repository'

class InvoiceItemRepositoryTest < Minitest::Test

  def setup
    @iir = InvoiceItemRepository.new
    @ii_1 = InvoiceItem.new({
      :id => 6,
      :item_id => 7,
      :invoice_id => 8,
      :quantity => 1,
      :unit_price => BigDecimal.new(10.99, 4),
      :created_at => Time.now,
      :updated_at => Time.now
    })
    @ii_2 = InvoiceItem.new({
      :id => 7,
      :item_id => 8,
      :invoice_id => 9,
      :quantity => 2,
      :unit_price => BigDecimal.new(99.99, 4),
      :created_at => Time.now,
      :updated_at => Time.now
    })
    @ii_2 = InvoiceItem.new({
      :id => 8,
      :item_id => 11,
      :invoice_id => 11,
      :quantity => 1,
      :unit_price => BigDecimal.new(5.99, 3),
      :created_at => Time.now,
      :updated_at => Time.now
    })
    @ii_4 = InvoiceItem.new({
      :id => 9,
      :item_id => 10,
      :invoice_id => 8,
      :quantity => 10,
      :unit_price => BigDecimal.new(10.99, 4),
      :created_at => Time.now,
      :updated_at => Time.now
    })
    @iir.collection << @ii_1
    @iir.collection << @ii_2
    @iir.collection << @ii_3
    @iir.collection << @ii_4
  end

  def test_it_exists
    assert_instance_of InvoiceItemRepository, @iir
  end

  def test_it_can_return_all_invoices
    assert_equal [@ii_1, @ii_2, @ii_3, @ii_4], @iir.all
  end

end
