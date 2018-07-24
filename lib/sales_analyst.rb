require 'pry'

class SalesAnalyst

  def initialize(items, merchants)
    @items = items
    @merchants = merchants
  end

  def merchants_by_id(merchant_array)
    merchant_array.group_by do |merchant|
      merchant.id
    end
  end

  def item_count_by_merchant(merchant_hash_by_id)
    merchant_hash_by_id.map do |id, items|
      items.count
    end
  end

  def total_items(item_count_by_merchant_array)
    item_count_by_merchant_array.inject(0) do |sum, number|
      sum += number
    end
  end

  def average_items_per_merchant
    merchant_hash = merchants_by_id(@merchants.merchants)
    item_count = item_count_by_merchant(merchant_hash)
    total_items(item_count).to_f / item_count.length
  end

  def average_items_per_merchant_standard_deviation

  end

end
