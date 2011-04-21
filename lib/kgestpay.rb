#encoding : utf-8
module Kemen

  class KGestPay
    require 'soap/wsdlDriver'

    def initialize(args)
      raise(ArgumentError.new(" Missing argument [:shopLogin] Variable @shopLogin cannot be initiliazed.")) if args[:shopLogin].nil?
      raise(ArgumentError.new(" Missing argument [:endpoint] Variable @endpoint cannot be initiliazed.")) if args[:endpoint].nil?
      @shopLogin = args[:shopLogin]
      @endpoint = args[:endpoint]
      #create the ws instance
      @ws = SOAP::WSDLDriverFactory.new("#{@endpoint}?WSDL").create_rpc_driver
      super
    end

    def callPagamS2S(args)

      #Required arguments
      [:uicCode, :amount, :shopTransactionId, :cardNumber, :expiryMonth, :expiryYear, :cvv, :buyerName, :buyerEmail].each do |arg|
        raise(ArgumentError.new("Parameter [:#{arg}] is required but has not been passed")) if args[arg.to_sym].nil?
      end

      args[:shopLogin] = @shopLogin

      #invoke the gestpay webservice method and return the result
      @ws.callPagamS2S(args).callPagamS2SResult.gestPayS2S

    end

    def callSettleS2S(args)

      #Required arguments
      [:uicCode, :amount].each do |arg|
        raise(ArgumentError.new("Parameter [:#{arg}] is required but has not been passed")) if args[arg.to_sym].nil?
      end

      #conditional requirments
      raise(ArgumentError.new("One between the parameters [:bankTransID] or [:shopTransID] is required.")) if args[:bankTransID].nil? && args[:shopTransID].nil?

      args[:shopLogin] = @shopLogin

      #invoke the gestpay webservice method and return the result
      @ws.callSettleS2S(args).callSettleS2SResult.gestPayS2S

    end

    def callDeleteS2S(args)

      #conditional requirments
      raise(ArgumentError.new("One between the parameters [:bankTransactionId] or [:shopTransactionId] is required.")) if args[:bankTransactionId].nil? && args[:shopTransactionId].nil?

      args[:shopLogin] = @shopLogin

      #invoke the gestpay webservice method and return the result
      @ws.callDeleteS2S(args).callDeleteS2SResult.gestPayS2S

    end

  end

end