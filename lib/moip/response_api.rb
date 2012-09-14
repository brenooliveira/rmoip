module Rmoip
	class ResponseApi

        attr_accessor :token, :status, :errors, :base_uri

        def initialize
            @errors = Array.new
        end

        def self.build(params)
        	response = self.new
        	response.token = params["Token"]
        	response.status = params["Status"]
        	params["Erro"].each do |erro|
                response.errors.push erro
        	end
            response
        end

        def is_successful
            self.status == "Sucesso"
        end

        def url
            @base_uri << "/Instrucao.do?token=" << token
        end

        def to_s
            "token #{token}, status: #{status}, Total de error: #{errors}"
        end
	end
end