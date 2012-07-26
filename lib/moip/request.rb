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

    def self.enviar_cobranca_unica(id_cobranca, &block)
      raise "Informe um token" unless token
      #xml = Moip::InstrucaoUnica.make_xml params
      puts "XML Instrucao Unica: "
    end

  end

end
