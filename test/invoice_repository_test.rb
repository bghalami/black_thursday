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
      :updated_at  => Time.now,
    })
    @invoice_2    = Invoice.new({
      :id          => 7,
      :customer_id => 8,
      :merchant_id => 9,
      :status      => "pending",
      :created_at  => Time.now,
      :updated_at  => Time.now,
    })
    @invoice_3 = Invoice.new({
      :id          => 19,
      :customer_id => 8,
      :merchant_id => 10,
      :status      => "pending",
      :created_at  => Time.now,
      :updated_at  => Time.now,
    })

    @invoice_repo.invoices << @invoice_1
    @invoice_repo.invoices << @invoice_2
    @invoice_repo.invoices << @invoice_3
  end

  def test_it_exists
    assert_instance_of InvoiceRepository, @invoice_repo
  end

  def it_can_return_all_invoices
    assert_equal [@invoice_1, @invoice_2, @invoice_3], @invoice_repo.all
  end
end
