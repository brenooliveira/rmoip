require "rubygems"
require "httparty"
require "nokogiri"
require "moip/request"
require "moip/commons"
require "moip/instrucao_unica"
require "moip/pagador"
require "moip/endereco"
require "moip/response_api"

module Rmoip

    def self.sandbox(token, key)
        self.request token, key, :SANDBOX
    end

    def self.production(token, key)
        self.request token, key, :PRODUCAO
    end

    private
	def self.request(token, key, env)
	  env = :PRODUCAO if env.nil? || env != :SANDBOX
	  Request.new(token, key, env)
	end

end
