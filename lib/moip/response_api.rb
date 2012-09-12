module Rmoip
	class ResponseApi

        attr_accessor :token, :status, :errors = []

        def self.build(params)
        	response = self.new
        	response.token = params["Token"]
        	response.status = params["Status"]
        	params["erro"].each do |erro|
                errors.push erro
        	end
        end

        def is_successful
            response.status == ˜Sucesso˜
        end

        def to_s
            "token #{token}, status: #{status}"
        end
	end
end