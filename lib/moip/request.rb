# encoding: utf-8
module Rmoip

  class Request
    include HTTParty

    attr_accessor :token, :key, :env

    def initialize(token, key, env)
      @token = token
      @key = key
      @env = env    
    end
    
    base_uri "https://desenvolvedor.moip.com.br/sandbox/ws/alpha/EnviarInstrucao/Unica"
    basic_auth @token, @key

    def cobrar_com_boleto(parameters)
      parameters[:forma] = "BoletoBancario"
      @parameters = parameters
    end
    
    def self.cobrar_com_cartao_de_credito(parameters)
      parameters[:forma] = "CartaoCredito"
      @parameters = parameters
    end
    
    def enviar_cobranca
      raise MissingIdProprioError, "É obrigatório informar um Id Proprio" if @parameters[:id_proprio].nil?
      raise MissingRazaoError, "É obrigatório informar uma Razao" if @parameters[:razao].nil?
      
      preparar_cobranca @parameters
    end
    
    private
    def preparar_cobranca(parameters)
      xml = Rmoip::InstrucaoUnica.make_xml parameters
    end
    
    def enviar(xml)
      puts "cobrar"
    end

  end

  class MissingIdProprioError < Exception
  end
  
  class MissingRazaoError < Exception
  end
end
