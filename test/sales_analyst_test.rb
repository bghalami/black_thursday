require_relative '../test/test_helper.rb'
require_relative '../lib/sales_engine'
require 'pry'


class SalesAnalystTest < Minitest::Test

  def setup
    @item_1 = Item.new({
      :id          => "263395237",
      :name        => "Pencil",
      :description => "Best Pencil EVER!",
      :unit_price  => "1200",
      :updated_at  => Time.now,
      :created_at  => Time.now,
      :merchant_id => "14"
      })

    @item_2 = Item.new({
      :id          => "263395238",
      :name        => "Pen",
      :description => "Best Pen EVER!",
      :unit_price  => "1400",
      :updated_at  => Time.now,
      :created_at  => Time.now,
      :merchant_id => "14"
      })

    @item_3 = Item.new({
      :id          => "263395239",
      :name        => "Ruler",
      :description => "Best Ruler EVER!",
      :unit_price  => "800",
      :updated_at  => Time.now,
      :created_at  => Time.now,
      :merchant_id => "15"
      })

    @item_array = [@item_1, @item_2, @item_3]

    @merchant1 = Merchant.new({id: 13, name: "Ben"})
    @merchant2 = Merchant.new({id: 13, name: "Jesse"})
    @merchant3 = Merchant.new({id: 15, name: "Sal"})

    @merchant_array = [@merchant1, @merchant2, @merchant3]
    @sales_engine = SalesEngine.new(@item_array, @merchant_array)
    @analyst = @sales_engine.analyst
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, @analyst
  end

  def test_it_can_return_average_items_per_merchant
    assert_equal 1.5, @analyst.average_items_per_merchant
  end

  def test_it_can_return_items_per_merchant_standard_deviation
    assert_equal 0.71, @analyst.average_items_per_merchant_standard_deviation
  end
end
