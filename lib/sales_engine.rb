require_relative '../lib/item_repository'
require_relative '../lib/merchant_repository'
require_relative '../lib/invoice_repository'
require_relative '../lib/customer_repository'
require_relative '../lib/transaction_repository'
require_relative '../lib/invoice_item_repository'
require_relative '../lib/sales_analyst'
require 'csv'

class SalesEngine

  attr_accessor :items,
                :merchants,
                :invoices,
                :customers,
                :invoice_items,
                :transactions

  def self.from_csv(hash)
    items_array        = []
    merchants_array    = []
    invoices_array     = []
    invoice_items_array = []
    transactions_array  = []

    if hash[:items]
      items_array = load_csv(hash[:items], Item)
    end

    if hash[:merchants]
      merchants_array = load_csv(hash[:merchants], Merchant)
    end

    if hash[:invoices]
      invoices_array = load_csv(hash[:invoices], Invoice)
    end

    if hash[:customers]
      customers_array = load_csv(hash[:customers], Customer)
    end

    if hash[:transactions]
      transactions_array = load_csv(hash[:transactions], Transaction)
    end

    if hash[:invoice_items]
      invoice_items_array = load_csv(hash[:invoice_items], InvoiceItem)
    end

    SalesEngine.new(
      items_array,
      merchants_array,
      invoices_array,
      customers_array,
      transactions_array,
      invoice_items_array
    )
  end

  def self.load_csv(location, class_name)
    csv_array = []
    CSV.foreach(location, headers: true, header_converters: :symbol) do |row|
      csv_array << class_name.new(row)
    end
    csv_array
  end

  def initialize(
   items_array        = [],
   merchants_array    = [],
   invoice_array      = [],
   customers_array    = [],
   transactions_array = [],
   invoice_items_array= []
  )

    @items     = ItemRepository.new(items_array)
    @merchants = MerchantRepository.new(merchants_array)
    @invoices  = InvoiceRepository.new(invoice_array)
    @customers = CustomerRepository.new(customers_array)
    @transactions = TransactionRepository.new(transactions_array)
    @invoice_items = InvoiceItemRepository.new(invoice_items_array)
  end

  def analyst
    SalesAnalyst.new(@items, @merchants, @invoices, @customers, @transactions, @invoice_items)
  end

end
