require_relative '../lib/invoice'

class InvoiceRepository

  attr_reader :invoices

  def initialize(invoices = [])
    @invoices = invoices
  end

  def all
    @invoices
  end

  def find_by_id(id)
    @invoices.find do |invoice|
      invoice.id == id
    end
  end

  def find_all_by_customer_id(id)
    @invoices.find_all do |invoice|
      invoice.customer_id == id
    end
  end

  def find_all_by_merchant_id(id)
    @invoices.find_all do |invoice|
      invoice.merchant_id == id
    end
  end

  def find_all_by_status(status)
    @invoices.find_all do |invoice|
      invoice.status.upcase.include?(status.upcase)
    end
  end

end
