require_relative '../test/test_helper.rb'
require_relative '../lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test
  def setup
    @merchant1 = Merchant.new({id: 13, name: "Ben"})
    @merchant2 = Merchant.new({id: 14, name: "Jesse"})
    @merchant3 = Merchant.new({id: 15, name: "Sal"})
    @merchant_array = [@merchant1, @merchant2, @merchant3]
    @merchant_repo = MerchantRepository.new(@merchant_array)
  end

  def test_it_exists
    assert_instance_of MerchantRepository, @merchant_repo
  end

  def test_it_has_somewhere_to_store_merchants
    assert_instance_of Array, @merchant_repo.collection
  end

  def test_it_can_load_merchants_from_csv
    refute @merchant_repo.collection.empty?
  end

  def test_it_can_return_all_merchants
    assert_equal @merchant_repo.collection, @merchant_repo.all
  end

  def test_it_can_find_a_merchant_by_id
    assert_equal @merchant_repo.collection[0], @merchant_repo.find_by_id(13)
  end

  def test_it_can_find_a_merchant_by_name
    assert_equal @merchant_repo.collection[0], @merchant_repo.find_by_name("Ben")
  end

  def test_it_find_all_by_name_fragment
    assert_equal 2, @merchant_repo.find_all_by_name("e").count
  end

  def test_it_can_create_merchants
    assert_equal 3, @merchant_repo.collection.count
    @merchant_repo.create({:name => "Sour Creamery"})
    assert_equal 4, @merchant_repo.collection.count
  end

  def test_it_can_update_attributes
    @merchant_repo.update(13, {:name => "Sour Creamery"})
    sour_creamy = @merchant_repo.find_by_id(13)
    assert_equal "Sour Creamery", sour_creamy.name
  end

  def test_it_can_delete_a_merchant
    assert_instance_of Merchant, @merchant_repo.find_by_id(13)
    @merchant_repo.delete(13)
    assert_nil @merchant_repo.find_by_id(13)
  end
end
