module Rmoip
  class Comissao
    include Commons

    private
    def valid_attr
      [ :razao, :valor_percentual, :valor_fixo, :mostrar_para_payer, :parcelada, :comissionado ]
    end
  end
end
