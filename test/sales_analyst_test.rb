require_relative '../test/test_helper.rb'
require_relative '../lib/sales_engine'
require 'pry'


class SalesAnalystTest < Minitest::Test

  def setup
    @t_1 = Transaction.new({
      :id => 6,
      :invoice_id => 8,
      :credit_card_number => "4242424242424242",
      :credit_card_expiration_date => "0221",
      :result => "success",
      :created_at => Time.now,
      :updated_at => Time.now
    })
    @t_2 = Transaction.new({
      :id => 7,
      :invoice_id => 9,
      :credit_card_number => "4242424242424243",
      :credit_card_expiration_date => "0222",
      :result => "success",
      :created_at => Time.now,
      :updated_at => Time.now
    })
    @t_3 = Transaction.new({
      :id => 8,
      :invoice_id => 9,
      :credit_card_number => "4242424242424244",
      :credit_card_expiration_date => "0223",
      :result => "failed",
      :created_at => Time.now,
      :updated_at => Time.now
    })
    @t_4 = Transaction.new({
      :id => 9,
      :invoice_id => 11,
      :credit_card_number => "4242424242424245",
      :credit_card_expiration_date => "0224",
      :result => "success",
      :created_at => Time.now,
      :updated_at => Time.now
    })
    @transactions_array = [@t_1, @t_2, @t_3, @t_4]

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
    @ii_3 = InvoiceItem.new({
      :id => 8,
      :item_id => 11,
      :invoice_id => 9,
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
    @invoice_item_array = [@ii_3, @ii_1, @ii_2, @ii_4]

    @invoice_1 = Invoice.new({
      :id          => 6,
      :customer_id => 7,
      :merchant_id => 8,
      :status      => "pending",
      :created_at  => Time.now,
      :updated_at  => Time.now,
    })

    @invoice_2 = Invoice.new({
      :id          => 7,
      :customer_id => 7,
      :merchant_id => 8,
      :status      => "pending",
      :created_at  => Time.now,
      :updated_at  => Time.now,
    })

    @invoice_3 = Invoice.new({
      :id          => 8,
      :customer_id => 6,
      :merchant_id => 13,
      :status      => "shipped",
      :created_at  => Time.now,
      :updated_at  => Time.now,
    })

    @invoice_4 = Invoice.new({
      :id          => 9,
      :customer_id => 6,
      :merchant_id => 13,
      :status      => "returned",
      :created_at  => Time.now,
      :updated_at  => Time.now,
    })

    @invoice_array = [@invoice_1, @invoice_2, @invoice_3, @invoice_4]

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

    @customer_array = []

    @sales_engine = SalesEngine.new(@item_array, @merchant_array, @invoice_array, @customer_array, @transactions_array, @invoice_item_array)
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

  def test_it_returns_golden_items
    assert_equal [], @analyst.golden_items
  end

  def test_it_returns_average_invoices_per_merchant
    assert_equal 2, @analyst.average_invoices_per_merchant
  end

  def test_it_groups_invoices_by_merchant_id
    actual    = @analyst.invoices_by_merchant_id(@analyst.invoices.collection)
    expected  = {13 => [@invoice_3,@invoice_4], 8 => [@invoice_1, @invoice_2]}
    assert_equal expected, actual

  end

  def test_it_gives_us_the_invoice_per_merchant_standard_deviation
    assert_equal 0, @analyst.average_invoices_per_merchant_standard_deviation
  end

  def test_it_returns_array_of_top_merchants_by_invoice_count
    assert_equal [], @analyst.top_merchants_by_invoice_count
  end

  def test_it_returns_an_array_of_bottom_merchants_by_invoice_count
    assert_equal [], @analyst.bottom_merchants_by_invoice_count
  end

  def test_it_returns_day_of_the_week_hash
    time = Time.now
    assert_equal ({time.wday => @invoice_array}), @analyst.day_of_the_week_hash
  end

  def test_it_returns_an_integer_of_counts_per_day
    assert_equal 4, @analyst.invoice_count_per_day_summed
  end

  def test_average_number_of_invoices_created_per_day
    assert_equal 0.57, @analyst.average_number_of_invoices_created_per_day
  end

  def test_it_returns_array_of_top_days_of_invoices
    Date.today.strftime("%A")
    assert_equal [Date.today.strftime("%A")], @analyst.top_days_by_invoice_count
  end

  def test_it_returns_the_standard_deviation_of_invoice_items_created_per_day
    assert_equal 1.4, @analyst.invoice_per_day_standard_deviation
  end

  def test_it_returns_hash_of_grouped_invoices
    assert_instance_of Hash, @analyst.group_by_invoice_status
  end

  def test_it_returns_the_percentage_of_invoices_with_status
    assert_equal 50.0, @analyst.invoice_status(:pending)
  end

  def test_invoice_paid_in_full_returns_true_if_status_is_success
    assert_equal true, @analyst.invoice_paid_in_full?(9)
  end

  def test_invoice_total_returns_correct_big_d
    assert_equal BigDecimal.new(205.97, 5), @analyst.invoice_total(9)
  end

  def test_it_returns_merchant_with_one_item
    assert_equal 1, @analyst.merchants_with_only_one_item.count
  end

  def test_it_return_array_of_merchants_with_only_one_invoice_that_month
    assert_equal 1, @analyst.merchants_with_only_one_item_registered_in_month(Time.now.strftime("%B")).count
  end

  def test_it_can_return_the_total_revenue_of_a_merchant
    assert_equal 326.86.to_d, @analyst.revenue_by_merchant(13)
  end

  def test_it_returns_an_array_of_the_highest_quanitity_item
    assert_equal [], @analyst.most_sold_item_for_merchant(13)
  end

  def test_it_returns_best_item_for_merchant_per_revenue
    refute @analyst.best_item_for_merchant(13)
  end

  def test_it_can_return_total_revenue_by_date
    date = Time.now
    assert_equal 326.86.to_d, @analyst.total_revenue_by_date(date.strftime("%F"))
  end
end
