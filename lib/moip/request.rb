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

    def send(parameters)
      raise MissingIdProprioError, "É obrigatório informar um Id Proprio" if @parameters[:id_proprio].nil?
      raise MissingRazaoError, "É obrigatório informar uma Razao" if @parameters[:razao].nil?

      request_moip parameters
    end

    def add_split
        return self
    end

    def add_parcel(parcel)
      @parcelamentos.push parcel
      return self
    end

    def get_url
      return uri << "/Instrucao.do?token=" << @response.token
    end

    private
    def request_moip(xml)
      xml = Rmoip::InstrucaoUnica.make_xml parameters
      options = { :base_uri => uri, :basic_auth => { :username => @token, :password => @key }, :body => xml }
      request = self.class.post "/ws/alpha/EnviarInstrucao/Unica", options
      response = Rmoip::ResponseApi.build request['EnviarInstrucaoUnicaResponse']['Resposta']
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
