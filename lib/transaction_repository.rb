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

  def find_all_by_credit_card_number(cc)
    @collection.find_all do |element|
      element.credit_card_number == cc
    end
  end

  def find_all_by_result(result)
    @collection.find_all do |element|
      element.result.to_s.include?(result.to_s)
    end
  end

  def find_all_paid_by_date(date)
    date = Time.parse(date) if date.class != Time
    @collection.find_all do |element|
      date.strftime("%F") == element.created_at.strftime("%F") && element.result == :success
    end
  end
end
