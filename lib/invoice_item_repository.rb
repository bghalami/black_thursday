require_relative '../lib/invoice_item'
require_relative '../lib/repository_helper'

class InvoiceItemRepository

  include RepositoryHelper

  attr_reader :collection

  def initialize(invoice_items_array = [])
    @collection = invoice_items_array
    @class = InvoiceItem
  end

  def find_all_by_item_id(id)
    @collection.find_all do |element|
      element.item_id == id
    end
  end
end
