require_relative '../test/test_helper'
require_relative '../lib/customer_repository'

class CustomerRepositoryTest < Minitest::Test

  def setup
    @c_repo = CustomerRepository.new
    @customer_1 = Customer.new({
      :id   => 20,
      :first_name => "Mark",
      :last_name => "Twain",
    })
    @customer_2 = Customer.new({
      :id   => 23,
      :first_name => "Willie",
      :last_name => "Nelson",
    })
  end

  def test_it_exists
    assert_instance_of CustomerRepository, @c_repo
  end

  def test_it_has_attributes
    assert_equal [], @c_repo.collection
    assert_equal Customer, @c_repo.class
  end

  def test_it_can_find_all_by_first_name
    @c_repo.collection << @customer_1
    @c_repo.collection << @customer_2

    assert_equal [@customer_1], @c_repo.find_all_by_first_name("Mark")
  end

  def test_it_can_find_all_by_last_name
    @c_repo.collection << @customer_1
    @c_repo.collection << @customer_2

    assert_equal [@customer_1], @c_repo.find_all_by_last_name("tw")
  end

end
