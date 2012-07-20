# encoding: utf-8
require 'httparty'

module Moip

  class Request
    include HTTParty
    
    #base_uri "#{MoIP.uri}/ws/alpha"
    #basic_auth MoIP.token, MoIP.key

    def self.intrucao_unica(parameters = {})
      xml = Moip::InstrucaoUnica.toXml params
      puts "XML Instrucao Unica: #{xml}"
    end
    
  end

end
