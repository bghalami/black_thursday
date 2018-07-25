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
      :merchant_id => "13"
      })

    @item_2 = Item.new({
      :id          => "263395238",
      :name        => "Pen",
      :description => "Best Pen EVER!",
      :unit_price  => "1400",
      :updated_at  => Time.now,
      :created_at  => Time.now,
      :merchant_id => "13"
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
    @merchant2 = Merchant.new({id: 14, name: "Sal"})
    @merchant3 = Merchant.new({id: 15, name: "Jesse"})

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

  def test_it_returns_merchants_above_one_standard_deviation
    assert_equal [], @analyst.merchants_with_high_item_count
  end

  def test_it_returns_the_average_item_price_for_given_merchant
    assert_equal BigDecimal(13.00, 4), @analyst.average_item_price_for_merchant(13)
  end

  def test_it_returns_the_average_of_the_average_price_of_merchants
    assert_equal BigDecimal(7.00,3), @analyst.average_average_price_per_merchant
  end

  def test_it_returns_total_item_price
    assert_equal BigDecimal(34.00,4), @analyst.total_item_price
  end

  def test_it_returns_items_2_standard_deviations_above_item_average
    assert_equal [], @analyst.golden_items
  end

  def test_it_returns_number_of_items
    assert_equal 3, @analyst.number_of_items
  end

  def test_it_returns_the_standard_deviation_of_item_price
    assert_equal 3.06, @analyst.standard_deviation_of_item_prices
  end

end
