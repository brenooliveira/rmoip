require "rubygems"
require "httparty"
require "moip/request"
require "moip/instrucao_unica"

module Rmoip

	def self.autenticacao(token, key, env)
	  env = :SANDBOX if env.nil? || env != :PRODUCAO
	  Request.new :token => token, :key => key, :env => env
	end
	
end
