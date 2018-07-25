require 'pry'

class SalesAnalyst

  attr_reader :items,
              :merchants

  def initialize(items, merchants, invoices)
    @items = items
    @merchants = merchants
    @invoices = invoices
  end

  def items_by_merchant_id(item_array)
    item_array.group_by do |item|
      item.merchant_id
    end
  end

  def item_count_by_merchant_id(item_hash_by_merchant_id)
    item_hash_by_merchant_id.map do |id, items|
      items.count.to_f
    end
  end

  def total_items(item_count_by_merchant_array)
    item_count_by_merchant_array.inject(0) do |sum, number|
      sum += number
    end
  end

  def average_items_per_merchant
    merchant_hash = items_by_merchant_id(@items.collection)
    item_count = item_count_by_merchant_id(merchant_hash)
    (total_items(item_count).to_f / item_count.length).round(2)
  end

  def average_items_per_merchant_standard_deviation
    average_items = average_items_per_merchant
    merchant_hash = items_by_merchant_id(@items.collection)
    item_count = item_count_by_merchant_id(merchant_hash)
    abs_differences = item_count.map do |count|
      ((count - average_items).abs) ** 2.0
    end
    total = abs_differences.inject(0) do |sum, number|
      sum += number
    end
    (Math.sqrt(total / (item_count.length - 1))).round(2)
  end

  def merchants_with_high_item_count
    the_mark = average_items_per_merchant + average_items_per_merchant_standard_deviation
    merchant_hash = items_by_merchant_id(@items.collection)
    split = @merchants.collection.map do |merchant|
      if merchant_hash[merchant.id]
        if ((merchant_hash[merchant.id]).count - the_mark) >= 0
          merchant
        end
      end
    end
    split.compact
  end

  def average_item_price_for_merchant(merchant_id)
    split = @items.find_all_by_merchant_id(merchant_id)

    sum_of_prices = split.inject(0) do |sum, item|
      sum += (item.unit_price)
    end

    (sum_of_prices / split.count).round(2)
  end

  def average_average_price_per_merchant
    merchant_hash = items_by_merchant_id(@items.collection)
    average_merchant_average = merchant_hash.map do |merchant_id, items|
        average_item_price_for_merchant(merchant_id)
    end
    averages_summed = average_merchant_average.inject(0) do |sum, bigd|
      sum += bigd
    end
    (averages_summed / @merchants.collection.count).round(2)
  end

  def total_item_price
    total = @items.collection.inject(0) do |sum, item|
      sum += item.unit_price
    end
  end

  def average_price
    total_item_price / number_of_items
  end

  def number_of_items
    number_of_items = @items.collection.count
  end

  def standard_deviation_of_item_prices
    abs_differences = @items.collection.map do |item|
        ((item.unit_price - average_price).abs) ** 2.0
    end
    total = abs_differences.inject(0) do |sum, number|
      sum += number
    end
    (Math.sqrt(total / (number_of_items - 1))).round(2)
  end

  def golden_items
    the_mark = (standard_deviation_of_item_prices * 2) + average_price
    count = @items.collection.map do |item|
      if (item.unit_price - the_mark) > 0
        item
      end
    end
    count.compact
  end

  def average_items_per_merchant
    merchant_hash = invoices_by_merchant_id(@invoices.collection)
    invoice_count =  invoice_count_by_merchant_id(merchant_hash)
    (total_invoices(invoice_count).to_f / invoice_count.length).round(2)
  end

  def invoices_by_merchant_id(collection)
    collection.group_by do |invoice|
      invoice.merchant_id
    end
  end

  def invoice_count_by_merchant_id(invoice_hash)
    invoice_hash.map do |id, invoices|
      invoices.count.to_f
    end
  end

  def total_invoices(invoice_count_by_merchant_array)
    invoice_count_by_merchant_array.inject(0) do |sum, number|
      sum += number
    end
  end
end
