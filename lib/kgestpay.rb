#encoding : utf-8
module Kemen

  class KGestPay

    def initialize(args)
      @shopLogin = args[:shopLogin]
      super
    end

    def callPagamS2S(args)
      #Required instance variable
      raise(RuntimeError.new("Variable @shopLogin has not been initialized")) if instance_variable_get(:@shopLogin).nil?

      #Required arguments
      [:uicCode,:amount,:shopTransactionId,:cardNumber,:expiryMonth,:expiryYear].each do |arg|
        raise(ArgumentError.new("Parameter [:#{arg}] is required but has not been passed")) if args[arg.to_sym].nil?
      end

    end

  end

end
