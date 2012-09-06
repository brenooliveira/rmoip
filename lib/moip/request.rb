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

    def cobrar(parameters)
      @parameters = parameters
      return self
    end

    def enviar_cobranca
      raise MissingIdProprioError, "É obrigatório informar um Id Proprio" if @parameters[:id_proprio].nil?
      raise MissingRazaoError, "É obrigatório informar uma Razao" if @parameters[:razao].nil?

      preparar_cobranca @parameters
    end

    def add_split
        return self
    end

    def add_parcel(parcel)
      @parcelamentos.push parcel
      return self
    end

    private
    def preparar_cobranca(parameters)
      xml = Rmoip::InstrucaoUnica.make_xml parameters
      enviar xml
    end

    def enviar(xml)
      options = { :base_uri => uri, :basic_auth => { :username => @token, :password => @key }, :body => xml }
      response = self.class.post "/ws/alpha/EnviarInstrucao/Unica", options
      response['status'] == "Sucesso"
    end

    def uri
      case @env 
      when :SANDBOX
        "https://desenvolvedor.moip.com.br/sandbox"
      when :PRODUCTION
        "https://www.moip.com.br"
      else
        raise InvalidEnvironmentErro, "É obrigatório informar o ENV"
      end
    end
  end

  class MissingIdProprioError < Exception
  end

  class InvalidEnvironmentErro < Exception
  end

  class MissingRazaoError < Exception
  end
end
