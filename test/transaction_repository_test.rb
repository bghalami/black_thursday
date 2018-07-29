require_relative '../test/test_helper.rb'
require_relative '../lib/transaction_repository'

class TransactionRepositoryTest < Minitest::Test
  def setup
    @tx_repo = TransactionRepository.new

    @t_1 = Transaction.new({
      :id => 6,
      :invoice_id => 8,
      :credit_card_number => "4242424242424242",
      :credit_card_expiration_date => "0221",
      :result => "success",
      :created_at => Time.now,
      :updated_at => Time.now
    })
    @t_2 = Transaction.new({
      :id => 7,
      :invoice_id => 9,
      :credit_card_number => "4242424242424243",
      :credit_card_expiration_date => "0222",
      :result => "success",
      :created_at => Time.now,
      :updated_at => Time.now
    })
    @t_3 = Transaction.new({
      :id => 8,
      :invoice_id => 10,
      :credit_card_number => "4242424242424244",
      :credit_card_expiration_date => "0223",
      :result => "failed",
      :created_at => Time.now,
      :updated_at => Time.now
    })
    @t_4 = Transaction.new({
      :id => 9,
      :invoice_id => 11,
      :credit_card_number => "4242424242424245",
      :credit_card_expiration_date => "0224",
      :result => "success",
      :created_at => Time.now,
      :updated_at => Time.now
    })

    @tx_repo.collection << @t_1
    @tx_repo.collection << @t_2
    @tx_repo.collection << @t_3
    @tx_repo.collection << @t_4
  end

  def test_it_exists
    assert_instance_of TransactionRepository, @tx_repo
  end

  def test_it_has_attributes
    assert_instance_of Array, @tx_repo.collection
    assert_instance_of Class, @tx_repo.class
  end

end
