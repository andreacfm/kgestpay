#encoding : utf-8

require 'rubygems'
require 'test/unit'
require 'rails/all'

require "kgestpay"

class KGestPayTest < Test::Unit::TestCase

  def setup
    @shopLogin = 'GESPAY51954'
  end

  def test_shoplogin_saved_as_instance_variable
    k = Kemen::KGestPay.new(
      :shopLogin => @shopLogin
    )
    assert_equal(k.instance_variable_get(:@shopLogin),@shopLogin)
  end

  def test_callPagamS2S_args
    k = Kemen::KGestPay.new(:shop => 'shop')
    assert_raise(RuntimeError){k.callPagamS2S(:amount => 1)}

    k = Kemen::KGestPay.new(:shopLogin => @shopLogin)
    assert_raise(ArgumentError){k.callPagamS2S(:amount => 1)}
    assert_raise(ArgumentError){k.callPagamS2S(:uicCode => 1)}

  end

end