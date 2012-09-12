module Rmoip
	class ResponseApi

        attr_accessor :token, :status        

        def self.build(params)
        	response = self.new
        	response.token = params["Token"]
        	response.status = params["Status"]
        	# params[:Resposta][:erro].each do |erro|

        	# end
        end

        def to_s
            "token #{token}, status: #{status}"
        end
	end
end