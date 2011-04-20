#encoding : utf-8

require 'rubygems'
require 'test/unit'
require 'rails/all'

require "kgestpay"

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
    assert_raise(ArgumentError){@k.callPagamS2S(:amount => 1,:shopTransactionId => 1,:cardNumber => 1,:expiryMonth => 1,:expiryYear => 1)}
    assert_raise(ArgumentError){@k.callPagamS2S(:uicCode => 1,:shopTransactionId => 1,:cardNumber => 1,:expiryMonth => 1,:expiryYear => 1)}
    assert_raise(ArgumentError){@k.callPagamS2S(:uicCode => 1,:amount => 1,:cardNumber => 1,:expiryMonth => 1,:expiryYear => 1)}
    assert_raise(ArgumentError){@k.callPagamS2S(:uicCode => 1,:amount => 1,:shopTransactionId => 1,:expiryMonth => 1,:expiryYear => 1)}
    assert_raise(ArgumentError){@k.callPagamS2S(:uicCode => 1,:amount => 1,:shopTransactionId => 1,:cardNumber => 1,:expiryYear => 1)}
    assert_raise(ArgumentError){@k.callPagamS2S(:uicCode => 1,:amount => 1,:shopTransactionId => 1,:cardNumber => 1,:expiryMonth => 1)}
    assert_nothing_raised(ArgumentError){@k.callPagamS2S(:uicCode => 1,:amount => 1,:shopTransactionId => 1,:cardNumber => 1,:expiryMonth => 1,:expiryYear => 1)}
  end

  def test_callPagamS2S_must_fail_passing_wrong_arguments
    resp = @k.callPagamS2S(:uicCode => 1,:amount => 1,:shopTransactionId => 1,:cardNumber => 1,:expiryMonth => 1,:expiryYear => 1)
    assert_equal('KO',resp.transactionResult)
  end

  def test_callPagamS2S_must_succeed
    resp = @k.callPagamS2S(
      :uicCode => 242,
      :amount => 1,
      :shopTransactionId => 2,
      :cardNumber => @cc['number'],
      :expiryMonth => @cc['exp_month'],
      :expiryYear => @cc['exp_year']
    )
    p resp
    assert_equal('OK',resp.transactionResult)
  end

end