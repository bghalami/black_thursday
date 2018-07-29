require_relative '../test/test_helper.rb'
require_relative '../lib/invoice_repository'

class InvoiceRepositoryTest < Minitest::Test
  def setup
    @invoice_repo = InvoiceRepository.new
    @invoice_1    = Invoice.new({
      :id          => 6,
      :customer_id => 7,
      :merchant_id => 8,
      :status      => "pending",
      :created_at  => Time.now,
      :updated_at  => Time.now
    })
    @invoice_2    = Invoice.new({
      :id          => 7,
      :customer_id => 8,
      :merchant_id => 9,
      :status      => "shipped",
      :created_at  => Time.now,
      :updated_at  => Time.now
    })
    @invoice_3 = Invoice.new({
      :id          => 19,
      :customer_id => 8,
      :merchant_id => 10,
      :status      => "shipped",
      :created_at  => Time.now,
      :updated_at  => Time.now
    })
    @invoice_4 = Invoice.new({
      :id          => 19,
      :customer_id => 12,
      :merchant_id => 10,
      :status      => "returned",
      :created_at  => Time.now,
      :updated_at  => Time.now
    })
    @invoice_repo.collection << @invoice_1
    @invoice_repo.collection << @invoice_2
    @invoice_repo.collection << @invoice_3
    @invoice_repo.collection << @invoice_4

  end

  def test_it_exists
    assert_instance_of InvoiceRepository, @invoice_repo
  end

  def test_it_can_return_all_invoices
    assert_equal [@invoice_1, @invoice_2, @invoice_3, @invoice_4], @invoice_repo.all
  end

  def test_it_can_find_by_id
    assert_equal @invoice_repo.collection[2], @invoice_repo.find_by_id(19)
    assert_equal @invoice_repo.collection[0], @invoice_repo.find_by_id(6)
    refute @invoice_repo.find_by_id(99)
  end

  def test_it_can_find_all_by_customer_id
    assert_equal [@invoice_2, @invoice_3], @invoice_repo.find_all_by_customer_id(8)
    assert_equal [@invoice_1], @invoice_repo.find_all_by_customer_id(7)
    assert_equal [], @invoice_repo.find_all_by_customer_id(88)
  end

  def test_it_can_find_all_by_merchant_id
    assert_equal [@invoice_2], @invoice_repo.find_all_by_merchant_id(9)
    assert_equal [], @invoice_repo.find_all_by_merchant_id(99)
  end

  def test_it_can_find_all_by_status
    assert_equal [@invoice_2, @invoice_3], @invoice_repo.find_all_by_status("SHI")
    assert_equal [], @invoice_repo.find_all_by_status("3832")
  end

  def test_it_can_find_all_shipped_invoices_by_date
    assert_equal [@invoice_2, @invoice_3], @invoice_repo.find_all_shipped_by_date("2018-7-28")
  end

end
