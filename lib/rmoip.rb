require "rubygems"
require "httparty"
require "nokogiri"
require "moip/request"
require "moip/instrucao_unica"

module Rmoip

	def self.login(token, key, env)
	  env = :PRODUCAO if env.nil? || env != :SANDBOX
	  Request.new(token, key, env)
	end

end
