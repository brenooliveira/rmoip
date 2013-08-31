module Rmoip
  class ResponseApi

    attr_reader :id, :token, :status, :errors, :base_uri

    def initialize(params, base_uri)
      @errors = []
      @base_uri = base_uri
      @id = params["ID"] if params["ID"]
      @token = params["Token"] if params["Token"]
      @status = params["Status"] if params["Status"]
      if params["Erro"]
        erro = params["Erro"]
        @errors << { "Codigo" => erro["Codigo"], "Mensagem" => erro["__content__"] }
      end
    end

    def success?
      status == "Sucesso"
    end

    def redirect_url
      %(#{base_uri}/Instrucao.do?token=#{@token})
    end

  end
end
