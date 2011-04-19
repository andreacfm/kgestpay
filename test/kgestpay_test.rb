require 'rubygems'
require 'test/unit'
require 'rails/all'

require "kgestpay"

class KGestPayTest < Test::Unit::TestCase

  def setup
    @k = Kemen::KGestPay.new
  end

  def test_craete_instance
    assert_not_nil @k
  end

end