require "rubygems"
require "httparty"
require "moip/request"
require "moip/instrucao_unica"

module Rmoip

	def self.da_loja(token, key, env)
	  env = :SANDBOX if env.nil? || env != :PRODUCAO
	  Request.new(token, key, env)
	end
	
end
