require "rubygems"
require 'moip/request'

module Rmoip

  # URI para acessar o serviço
  attr_accessor :uri
  @@env = 'https://www.moip.com.br'

  # Token de autenticação
  attr_accessor :token

  # Chave de acesso ao serviço
  attr_accessor :key

	def self.config
	  yield self
	end

end
