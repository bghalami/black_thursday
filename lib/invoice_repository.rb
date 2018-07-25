require_relative '../lib/invoice'
require_relative '../lib/repository_helper'

class InvoiceRepository

  include RepositoryHelper

  attr_reader :collection

  def initialize(invoices = [])
    @collection = invoices
    @class = Invoice
  end
end
