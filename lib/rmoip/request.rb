# encoding: utf-8
module Rmoip
  class Request
    include HTTParty

    attr_accessor :token, :key, :env

    def initialize(token, key, env)
      @token = token
      @key = key
      @env = env
      @parcels = Array.new
      @splits = Array.new
      @is_to_validate = false
    end

    def send(parameters)
      raise MissingUniqueIdError, "É obrigatório informar um Id Proprio" if parameters[:unique_id].nil?
      raise MissingReasonError, "É obrigatório informar uma Razao" if parameters[:reason].nil?
      raise InvalidValue, "O valor deve ser maior que 0" if Float(parameters[:value]) <= 0
      response = request_moip parameters
      response
    end

    def add_split(split)
      raise MissingLoginMoip, "É obrigatório informar o LoginMoip" if split[:login_moip].nil?
      raise InvalidComissionValue, "Informe um valor percentual ou fixo" if split[:valor_fixo].nil? && split[:valor_percentual].nil?
      @splits.push split
      return self
    end

    def add_parcel(parcel)
      raise InvalidMinValue, "O valor mínimo deve ser superior a 1" if parcel[:min] <= 0
      raise InvalidMaxValue, "Este valor não parece ser um valor válido" if parcel[:max] >= 18
      raise MissingJurosError, "É obrigatorio informar o Juros" if parcel[:juros].nil?
      @parcels.push parcel
      return self
    end

    def validate
      @is_to_validate = true
      self
    end

    def get_url
      return uri << "/Instrucao.do?token=" << @response.token
    end

    private
    def request_moip(parameters)
      xml = prepare_hash(parameters)
      options = { :base_uri => uri, :basic_auth => { :username => @token, :password => @key }, :body => xml }
      request = self.class.post "/ws/alpha/EnviarInstrucao/Unica", options
      response = Rmoip::ResponseApi.build request['EnviarInstrucaoUnicaResponse']['Resposta']
      response.base_uri = uri
      response
    end

    def prepare_hash(parameters)
      parameters[:parcelamentos] = @parcels
      parameters[:comissoes] = @splits
      parameters[:validate] = @is_to_validate
      xml = Rmoip::InstrucaoUnica.make_xml parameters      
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

  class MissingUniqueIdError < Exception
  end

  class InvalidEnvironmentErro < Exception
  end

  class InvalidValue < Exception
  end

  class MissingReasonError < Exception
  end

  class InvalidMinValue < Exception
  end

  class InvalidMaxValue < Exception
  end

  class MissingLoginMoip < Exception
  end

  class MissingJurosError < Exception
  end

  class InvalidComissionValue < Exception
  end
end