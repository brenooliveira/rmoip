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
require "rmoip/comissao"
require "rmoip/recebedor"
require "rmoip/formas_pagamento"
require "rmoip/boleto"
require "rmoip/response_api"

module Rmoip

    def self.sandbox(token, key)
        self.request token, key, :SANDBOX
    end

    def self.production(token, key)
        self.request token, key, :PRODUCAO
    end

	def self.request(token, key, env)
	  env = :PRODUCAO if env.nil? || env != :SANDBOX
	  Request.new(token, key, env)
	end

end
