require_relative '../lib/customer'
require_relative '../lib/repository_helper'

class CustomerRepository

  include RepositoryHelper

  attr_reader :collection,
              :class

  def initialize(customers_array = [])
      @collection = customers_array
      @class = Customer
  end

  def find_all_by_first_name(first_name)
    @collection.find_all do |element|
      element.first_name.upcase.include?(first_name.upcase)
    end
  end

  def find_all_by_last_name(last_name)
    @collection.find_all do |element|
      element.last_name.upcase.include?(last_name.upcase)
    end
  end
end
