require_relative '../lib/item_repository'
require_relative '../lib/merchant_repository'
require_relative '../lib/invoice_repository'
require_relative '../lib/sales_analyst'
require 'csv'

class SalesEngine

  attr_accessor :items,
                :merchants,
                :invoices

  def self.from_csv(hash)
    items_array = []
    merchants_array = []
    invoices_array = []

    if hash[:items]
      items_array = load_csv(hash[:items], Item)
    end

    if hash[:merchants]
      merchants_array = load_csv(hash[:merchants], Merchant)
    end

    if hash[:invoices]
      invoices_array = load_csv(hash[:invoices], Invoice)
    end

    SalesEngine.new(items_array, merchants_array, invoices_array)
  end

  def self.load_csv(location, class_name)
    csv_array = []
    CSV.foreach(location, headers: true, header_converters: :symbol) do |row|
      csv_array << class_name.new(row)
    end
    csv_array
  end

  def initialize(items_array = [],
                 merchants_array = [],
                 invoice_array = [])

    @items     = ItemRepository.new(items_array)
    @merchants = MerchantRepository.new(merchants_array)
    @invoices  = InvoiceRepository.new(invoice_array)
  end

  def analyst
    SalesAnalyst.new(@items, @merchants, @invoices)
  end

end
