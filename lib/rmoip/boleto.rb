module Rmoip
  class Boleto
    include Commons

    private
    def valid_attr
      [ :instrucao_1, :instrucao_2, :instrucao_3, :url_logo ]
    end
  end
end
