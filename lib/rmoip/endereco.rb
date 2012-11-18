module Rmoip
  class Endereco
    include Commons

    def to_xml
      Builder::XmlMarkup.new.EnderecoCobranca do |xml|
        xml.Logradouro logradouro if logradouro
        xml.Numero numero if numero
        xml.Complemento complemento if complemento
        xml.Bairro bairro if bairro
        xml.Cidade cidade if cidade
        xml.Estado estado if estado
        xml.Pais pais if pais
        xml.CEP cep if cep
        xml.TelefoneFixo telefone_fixo if telefone_fixo
      end
    end

    private
    def valid_attr
      [ :logradouro, :numero, :complemento, :bairro, :cidade, :estado, :pais,
        :cep, :telefone_fixo ]
    end
  end
end
