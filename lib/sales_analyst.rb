require 'pry'

class SalesAnalyst

  attr_reader :items,
              :merchants

  def initialize(items, merchants)
    @items = items
    @merchants = merchants
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
    merchant_hash = items_by_merchant_id(@items.items)
    item_count = item_count_by_merchant_id(merchant_hash)
    (total_items(item_count).to_f / item_count.length).round(2)
  end

  def average_items_per_merchant_standard_deviation
    average_items = average_items_per_merchant
    merchant_hash = items_by_merchant_id(@items.items)
    item_count = item_count_by_merchant_id(merchant_hash)
    abs_differences = item_count.map do |count|
      ((count - average_items).abs) ** 2.0
    end
    total = abs_differences.inject(0) do |sum, number|
      sum += number
    end
    (Math.sqrt(total / (item_count.length - 1))).round(2)
  end

end
