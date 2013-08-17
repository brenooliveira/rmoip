module Rmoip
  class Pagador
    include Commons

    def endereco_cobranca(*args, &block)
      @endereco_cobranca ||= with_block(Endereco, &block) || with_param(*args)
    end

    def to_xml
      Builder::XmlMarkup.new.Pagador do |xml|
        xml.Nome nome if nome
        xml.LoginMoIP login_moip if login_moip
        xml.Email email if email
        xml.IdPagador id_pagador if id_pagador
        xml.TelefoneCelular telefone_celular if telefone_celular
        xml.Apelido apelido if apelido
        xml.Identidade identidade if identidade

        xml << endereco_cobranca.to_xml if endereco_cobranca
      end
    end

    private
      def valid_attr
        [ :nome, :login_moip, :id_pagador, :email, :telefone_celular,
          :apelido, :identidade ]
      end
  end
end
