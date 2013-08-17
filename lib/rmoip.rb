require "rubygems"
require "httparty"
require "nokogiri"
require "builder"
require "rmoip/request"
require "rmoip/commons"
require "rmoip/instrucao_unica"
require "rmoip/pagador"
require "rmoip/endereco"
require "rmoip/parcelamento"
require "rmoip/comissoes"
require "rmoip/comissao"
require "rmoip/recebedor"
require "rmoip/formas_pagamento"
require "rmoip/boleto"
require "rmoip/mensagens"
require "rmoip/response_api"

module Rmoip

  class << self

    def sandbox(token, key)
      request token, key, :sandbox
    end

    def production(token, key)
      request token, key, :production
    end

    private
    def request(token, key, env)
      Request.new(token, key, env)
    end

  end

end
