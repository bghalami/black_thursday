require_relative '../lib/transaction'
require_relative '../lib/repository_helper'

class TransactionRepository

  include RepositoryHelper

  attr_accessor :collection
  attr_reader   :class

  def initialize(transactions_array = [])
    @collection = transactions_array
    @class = Transaction
  end
end
