module Rmoip
  class Endereco
    include Commons

    private
    def valid_attr
      [ :logradouro, :numero, :complemento, :bairro, :cidade, :estado, :pais,
        :cep, :telefone_fixo ]
    end
  end
end