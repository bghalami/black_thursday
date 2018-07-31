require 'pry'

class SalesAnalyst

  attr_reader :items,
              :merchants,
              :invoices,
              :customers,
              :invoice_items,
              :transactions

  def initialize(items, merchants, invoices, customers, transactions, invoice_items)
    @items = items
    @merchants = merchants
    @invoices = invoices
    @customers = customers
    @transactions = transactions
    @invoice_items = invoice_items
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
    @items.collection.inject(0) do |sum, item|
      sum += item.unit_price
    end
  end

  def average_price
    total_item_price / number_of_items
  end

  def number_of_items
    @items.collection.count
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
      if item.unit_price > the_mark
        item
      end
    end
    count.compact
  end

  def average_invoices_per_merchant
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

  def average_invoices_per_merchant_standard_deviation
    merchant_hash = invoices_by_merchant_id(@invoices.collection)
    invoice_count = invoice_count_by_merchant_id(merchant_hash)
    abs_differences = invoice_count.map do |count|
        ((count - average_invoices_per_merchant).abs) ** 2.0
    end
    total = abs_differences.inject(0) do |sum, number|
      sum += number
    end
    (Math.sqrt(total / (invoice_count.count - 1))).round(2)
  end

  def top_merchants_by_invoice_count
    merchant_hash = invoices_by_merchant_id(@invoices.collection)
    the_mark = (average_invoices_per_merchant_standard_deviation * 2) + average_invoices_per_merchant

    count = merchant_hash.map do |merchant_id, count|
      if count.length > the_mark
        @merchants.find_by_id(merchant_id)
      end
    end
    count.compact
  end

  def bottom_merchants_by_invoice_count
    merchant_hash = invoices_by_merchant_id(@invoices.collection)
    the_mark = average_invoices_per_merchant - (average_invoices_per_merchant_standard_deviation * 2)

    count = merchant_hash.map do |merchant_id, count|
      if count.length < the_mark
        @merchants.find_by_id(merchant_id)
      end
    end
    count.compact
  end

  def day_of_the_week_hash
    @invoices.collection.group_by do |invoice|
      (invoice.created_at).wday
    end
  end

  def count_per_day
    day_of_the_week_hash.map do |day, invoices|
      invoices.count
    end
  end

  def invoice_count_per_day_summed
    count_per_day.inject(0) do |sum, count|
      sum += count
    end
  end

  def average_number_of_invoices_created_per_day
    (invoice_count_per_day_summed.to_f / 7).round(2)
  end

  def top_days_by_invoice_count
    count_per_day = day_of_the_week_hash.map do |day, invoices|
      invoices.count
    end
  end

  def invoice_per_day_standard_deviation
    average = average_number_of_invoices_created_per_day
    abs_differences = count_per_day.map do |count|
        ((count - average).abs) ** 2.0
    end
    total = abs_differences.inject(0) do |sum, number|
      sum += number
    end
    (Math.sqrt(total / 6)).round(2)
  end

  def weekify(day_of_week_int)
    weekday_hash = {
      0 => "Sunday",
      1 => "Monday",
      2 => "Tuesday",
      3 => "Wednesday",
      4 => "Thursday",
      5 => "Friday",
      6 => "Saturday",
      7 => "Sunday"
    }
    weekday_hash.default("")
    weekday_hash[day_of_week_int]
  end

  def top_days_by_invoice_count
    the_mark = average_number_of_invoices_created_per_day + invoice_per_day_standard_deviation
    day_hash = day_of_the_week_hash
    days = day_hash.map do |day, count|
      if count.length > the_mark
        day
      end
    end
    (days.compact).map do |day|
      weekify(day)
    end
  end

  def group_by_invoice_status
    @invoices.collection.group_by do |invoice|
      invoice.status
    end
  end

  def invoice_status(status)
    status_count = group_by_invoice_status[status].count
    total_invoices = @invoices.collection.count
    ((status_count.to_f / total_invoices) * 100).round(2)
  end

  def invoice_paid_in_full?(invoice_id)
    transactions = @transactions.find_all_by_invoice_id(invoice_id)
    if transactions != []
      transactions.any? do |transaction|
        transaction.result == :success
      end
    else
      false
    end
  end

  def invoice_total(invoice_ide)
    invoice_items = @invoice_items.find_all_by_invoice_id(invoice_ide)
    prices = invoice_items.map do |invoice_item|
      invoice_item.unit_price * invoice_item.quantity
    end
    total_price = prices.inject do |sum, number|
      sum + number
    end
    total_price.round(2)
  end

  def merchants_with_only_one_item
    items_by_merchant = @items.collection.group_by do |item|
      item.merchant_id
    end
    merchants_with_one = items_by_merchant.select do |merchant_id, items|
      items.length == 1
    end
    final_merchants = merchants_with_one.map do |merchant_id, items|
      @merchants.find_by_id(merchant_id)
    end
  end

  def merchants_with_only_one_item_registered_in_month(month_name)
    month_name_hash = {
      "January" => 1,
      "February" => 2,
      "March" => 3,
      "April" => 4,
      "May" => 5,
      "June" => 6,
      "July" => 7,
      "August" => 8,
      "September" => 9,
      "October" => 10,
      "November" => 11,
      "December" => 12,
    }
    merchants = merchants_with_only_one_item.group_by do |merchants|
      (merchants.created_at).month
    end
    merchants[month_name_hash[month_name]]
  end

  def revenue_by_merchant(merchant_id)
    invoices = @invoices.find_all_by_merchant_id(merchant_id)
    invoice_item_total = invoices.map do |invoice|
      if invoice_paid_in_full?(invoice.id)
        invoice_total(invoice.id)
      end
    end.compact
    total = invoice_item_total.inject(0) do |sum, num|
      sum += num
    end
    total.round(2)
  end

  def most_sold_item_for_merchant(merchant_id)
    invoices = @invoices.find_all_by_merchant_id(merchant_id)
    valid_transactions = valid_transactions(invoices)
    invoice_items = valid_invoice_items(valid_transactions)
    grouped_items = invoice_items.group_by do |invoice_item|
      invoice_item.item_id
    end
    qty_of_items = quantities_of_items(grouped_items)
    qty = qty_of_items.sort_by do |item_id, quantity|
      quantity
    end
    final = get_quantity_of_items(qty)
    final.compact
  end

  def get_quantity_of_items(qty)
    qty.map do |item_id, quantity|
      if quantity == qty[-1][1]
        @items.find_by_id(item_id)
      else
        next
      end
    end
  end

  def best_item_for_merchant(merchant_id)
    invoices = @invoices.find_all_by_merchant_id(merchant_id)
    valid_transactions = valid_transactions(invoices)
    validated_invoice_items = valid_invoice_items(valid_transactions)
    grouped_items = group_valid_invoice_items(validated_invoice_items)
    quantity_of_items = quantity_of_items(grouped_items)
    qty = quantity_of_items.sort_by do |item_id, quantity|
      quantity
    end
    @items.find_by_id(qty[-1][0])
  end
  
  #--Begin Helper methods
  def valid_transactions(invoices)
    invoices.select do |invoice|
      invoice_paid_in_full?(invoice.id)
    end
  end

  def valid_invoice_items(valid_transactions)
    invoice_items = valid_transactions.map do |invoice|
      @invoice_items.find_all_by_invoice_id(invoice.id)
    end.flatten
  end

  def group_valid_invoice_items(valid_invoice_items)
    valid_invoice_items.group_by do |invoice_item|
      invoice_item.item_id
    end
  end

  def quantity_of_items(grouped_items)
    grouped_items.map do |item_id, invoice_items|
      [item_id, invoice_items.inject(0) do |sum, invoice_item|
        sum += (invoice_item.quantity * invoice_item.unit_price)
      end ]
    end
  end

  def quantities_of_items(grouped_items)
    grouped_items.map do |item_id, invoice_items|
      [item_id, invoice_items.inject(0) do |sum, invoice_item|
        sum += invoice_item.quantity
      end ]
    end
  end
  #--End of Helper methods

  def merchants_with_pending_invoices
    invoice_paid_array = @invoices.collection.map do |invoice|
      [invoice, invoice_paid_in_full?(invoice.id)]
    end
    merchants = invoice_paid_array.map do |invoice, pending|
      if pending == false
        @merchants.find_by_id(invoice.merchant_id)
      end
    end.compact
    merchants.uniq
  end

  def top_revenue_earners(count = 20)
    sorted_merchants = merchants_ranked_by_revenue
    sorted_merchants[0, count]
  end


  def get_all_paid_invoice_items
    @invoice_items.collection.find_all do |invoice_item|
      invoice_paid_in_full?(invoice_item.invoice_id)
    end
  end

  def total_revenue_by_date(date)
    date = Time.parse(date) if date.class != Time
    paid_invoices_by_date = @invoices.collection.find_all do |element|
      date.strftime("%F") == element.created_at.strftime("%F") && invoice_paid_in_full?(element.id)
    end
    total_revenue(paid_invoices_by_date)
  end

  def total_revenue(paid_invoices_by_date)
    total_revenue = 0.0.to_d
    paid_invoices_by_date.each do |invoice|
      @invoice_items.collection.each do |invoice_item|
        if invoice.id == invoice_item.invoice_id
          total_revenue += invoice_item.unit_price * invoice_item.quantity
        end
      end
    end
    total_revenue
  end

  def merchants_ranked_by_revenue
    merchant_revenue_array = @merchants.collection.map do |merchant|
      [merchant, revenue_by_merchant(merchant.id)]
    end
    sorted_by_revenue = merchant_revenue_array.sort_by do |merchant, revenue|
      revenue
    end
    biggest_to_smallest = sorted_by_revenue.reverse
    sorted_merchants = biggest_to_smallest.map do |merchant, revenue|
      merchant
    end
  end
end
