require_relative '../test/test_helper.rb'
require_relative '../lib/customer'

class MerchantTest < Minitest::Test
  def setup
    @customer = Customer.new({
      :id   => 20,
      :first_name => "Mark",
      :last_name => "Twain",
    })
  end

  def test_it_exists
    assert_instance_of Customer, @customer
  end

  def test_it_has_attributes
    assert_equal 20, @customer.id
    assert_equal "Mark", @customer.first_name
    assert_equal "Twain", @customer.last_name
    assert_instance_of Time, @customer.created_at
    assert_instance_of Time, @customer.updated_at
  end

end
