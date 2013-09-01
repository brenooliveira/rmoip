module Rmoip

  class NASP

    AUTHORIZED = "1"
    INITIATED = "2"
    BOLETO_PRINTED = "3"
    CONCLUDED = "4"
    CANCELED = "5"
    ANALYSIS = "6"
    REVERSED = "7"
    REFUNDED = "8"

    def initialize(params = {})
      @params = params
    end

    def id_transacao
      @params[:id_transacao]
    end

    def status
      @params[:status_pagamento]
    end

    def canceled?
      status == CANCELED
    end

  end

end
