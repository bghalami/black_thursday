require_relative '../lib/merchant'
require_relative '../lib/repository_helper'

class MerchantRepository

  include RepositoryHelper

  attr_reader :collection

  def initialize(merchants_array = [])
      @collection = merchants_array
      @class = Merchant
  end
end
