require_relative '../lib/item'
require_relative '../lib/repository_helper'

class ItemRepository

  include RepositoryHelper

  attr_accessor :collection

  def initialize(items = [])
    @collection = items
    @class = Item
  end
end
