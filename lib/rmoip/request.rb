# encoding: utf-8
module Rmoip
  class Request
    include HTTParty

    attr_reader :token, :key, :env

    ENVS = {
      sandbox: "https://desenvolvedor.moip.com.br/sandbox",
      production: "https://www.moip.com.br"
    }

    def initialize(token, key, env)
      @token = token
      @key = key
      @env = env
    end

    def send_instrucao_unica(&block)
      instrucao_unica = InstrucaoUnica.new(&block)

      send_to_moip instrucao_unica
    end

    def get_url
      return uri << "/Instrucao.do?token=" << @response.token
    end

    private
    def send_to_moip(instrucao_unica)
      xml = instrucao_unica.to_xml
      options = { :base_uri => base_uri, :basic_auth => { :username => @token, :password => @key }, :body => xml }
      reponse = self.class.post "/ws/alpha/EnviarInstrucao/Unica", options
      Rmoip::ResponseApi.new(reponse['EnviarInstrucaoUnicaResponse']['Resposta'], base_uri)
    end

    def base_uri
      ENVS[@env].tap do |uri|
        raise InvalidEnvironmentError, "É obrigatório informar o ENV" unless uri
      end
    end

  end

  class InvalidEnvironmentError < StandardError
  end

end
