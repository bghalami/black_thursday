require_relative '../lib/invoice'
require_relative '../lib/repository_helper'

class InvoiceRepository

  include RepositoryHelper

  attr_reader :collection

  def initialize(invoices = [])
    @collection = invoices
    @class = Invoice
  end

  def find_all_by_status(status)
    @collection.find_all do |element|
      element.status.to_s.upcase.include?(status.to_s.upcase)
    end
  end


end
