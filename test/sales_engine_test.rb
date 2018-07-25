require_relative '../test/test_helper.rb'
require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test
  def setup
    @sales_engine = SalesEngine.new
  end

  def test_it_exists
    assert_instance_of SalesEngine, @sales_engine
  end

  def test_it_has_attributes
    assert_equal [], @sales_engine.items.collection
    assert_equal [], @sales_engine.merchants.collection
  end
end
