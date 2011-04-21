#encoding : utf-8

require 'rubygems'
require 'test/unit'
require 'rails/all'

require_relative "../lib/kgestpay"

class KGestPayTest < Test::Unit::TestCase

  def setup
    @shopLogin = 'GESPAY51954'
    @endpoint = 'https://testecomm.sella.it/gestpay/gestpayws/WSs2s.asmx'
    @k = Kemen::KGestPay.new(:shopLogin => @shopLogin, :endpoint => @endpoint)
    @cc = YAML::load( File.open( 'test/cc.yml' ) )
  end

  def test_shoplogin_saved_as_instance_variable
    assert_equal(@k.instance_variable_get(:@shopLogin),@shopLogin)
    assert_equal(@k.instance_variable_get(:@endpoint),@endpoint)
    assert_equal(@k.instance_variable_get(:@ws).proxy.endpoint_url,@endpoint)
  end

  def test_callPagamS2S_args
    assert_raise(ArgumentError){@k.callPagamS2S(:amount => 1,:shopTransactionId => 1,:cardNumber => 1,:expiryMonth => 1,:expiryYear => 1,:cvv => 1,:buyerName => 1, :buyerEmail => 1)}
    assert_raise(ArgumentError){@k.callPagamS2S(:uicCode => 1,:shopTransactionId => 1,:cardNumber => 1,:expiryMonth => 1,:expiryYear => 1,:cvv => 1,:buyerName => 1, :buyerEmail => 1)}
    assert_raise(ArgumentError){@k.callPagamS2S(:uicCode => 1,:amount => 1,:cardNumber => 1,:expiryMonth => 1,:expiryYear => 1,:cvv => 1,:buyerName => 1, :buyerEmail => 1)}
    assert_raise(ArgumentError){@k.callPagamS2S(:uicCode => 1,:amount => 1,:shopTransactionId => 1,:expiryMonth => 1,:expiryYear => 1,:cvv => 1,:buyerName => 1, :buyerEmail => 1)}
    assert_raise(ArgumentError){@k.callPagamS2S(:uicCode => 1,:amount => 1,:shopTransactionId => 1,:cardNumber => 1,:expiryYear => 1,:cvv => 1,:buyerName => 1, :buyerEmail => 1)}
    assert_raise(ArgumentError){@k.callPagamS2S(:uicCode => 1,:amount => 1,:shopTransactionId => 1,:cardNumber => 1,:expiryMonth => 1,:cvv => 1,:buyerName => 1, :buyerEmail => 1)}
    assert_raise(ArgumentError){@k.callPagamS2S(:uicCode => 1,:amount => 1,:shopTransactionId => 1,:cardNumber => 1,:expiryMonth => 1,:expiryYear => 1,:buyerName => 1, :buyerEmail => 1)}
    assert_raise(ArgumentError){@k.callPagamS2S(:uicCode => 1,:amount => 1,:shopTransactionId => 1,:cardNumber => 1,:expiryMonth => 1,:expiryYear => 1,:cvv => 1, :buyerEmail => 1)}
    assert_raise(ArgumentError){@k.callPagamS2S(:uicCode => 1,:amount => 1,:shopTransactionId => 1,:cardNumber => 1,:expiryMonth => 1,:expiryYear => 1,:cvv => 1,:buyerName => 1)}
  end

  def test_callPagamS2S_must_fail_passing_wrong_arguments
    resp = @k.callPagamS2S(:uicCode => 1,:amount => 1,:shopTransactionId => 1,:cardNumber => 1,:expiryMonth => 1,:expiryYear => 1, :cvv => 1, :buyerName => 1, :buyerEmail => 1)
    assert_equal('KO',resp.transactionResult)
  end

=begin
  def test_callPagamS2S_must_succeed
    resp = @k.callPagamS2S(
      :uicCode => 242,
      :amount => 0.1,
      :shopTransactionId => 2,
      :cardNumber => @cc['number'],
      :expiryMonth => @cc['exp_month'],
      :expiryYear => @cc['exp_year'],
      :cvv => @cc['cvv'],
      :buyerName => @cc['name'],
      :buyerEmail => @cc['email']
    )
    assert_equal('OK',resp.transactionResult)
  end
=end

  def test_callSettle_s2s_args
    assert_raise(ArgumentError){@k.callSettleS2S(:uicCode => 1,:bankTransId => 1)}
    assert_raise(ArgumentError){@k.callSettleS2S(:amout => 1,:shopTransId => 1)}
    assert_raise(ArgumentError){@k.callSettleS2S(:uicCode => 1,:amout => 1)}
  end

=begin
  def test_callSetlleS2S_fails_with_code_2019_if_MOTO_cash_automatically
    resp = @k.callPagamS2S(
      :uicCode => 242,
      :amount => 0.1,
      :shopTransactionId => rand(1000000),
      :cardNumber => @cc['number'],
      :expiryMonth => @cc['exp_month'],
      :expiryYear => @cc['exp_year'],
      :cvv => @cc['cvv'],
      :buyerName => @cc['name'],
      :buyerEmail => @cc['email']
    )
    assert_equal('OK',resp.transactionResult)

    resp2 = @k.callSettleS2S(
        :bankTransID => resp.bankTransactionID,
        :uicCode => 242,
        :amount => 0.1
    )

    assert_equal('KO',resp2.transactionResult)
    assert_equal('2019', resp2.errorCode)

  end
=end



end