require_relative '../test/test_helper.rb'
require_relative '../lib/transaction'

class TransactionTest < Minitest::Test
  def setup
    @tx = Transaction.new({
      :id => 6,
      :invoice_id => 8,
      :credit_card_number => "4242424242424242",
      :credit_card_expiration_date => "0220",
      :result => "success",
      :created_at => Time.now,
      :updated_at => Time.now
    })
  end

  def test_it_exists
    assert_instance_of Transaction, @tx
  end

  def test_it_has_attributes
    assert_equal 6, @tx.id
    assert_equal 8, @tx.invoice_id
    assert_equal "4242424242424242", @tx.credit_card_number
    assert_equal "0220", @tx.credit_card_expiration_date
    assert_equal :success, @tx.result
    assert_instance_of Time, @tx.created_at
    assert_instance_of Time, @tx.created_at
  end
end
