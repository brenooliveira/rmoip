module Rmoip
  class Comissao
    include Commons

    private
    def valid_attr
      [ :razao, :valor_percentual, :valor_fixo, :mostrar_para_payer,
        :parcelada, :comissionado, :pagador_taxa ]
    end

    def required_attr
      [ :razao, :comissionado ]
    end
  end
end
