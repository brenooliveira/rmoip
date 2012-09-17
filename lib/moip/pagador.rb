module Rmoip
  class Pagador
    include Commons

    def endereco_cobranca(&block)
      @endereco_cobranca ||= Endereco.new &block
    end

    def to_xml
      Nokogiri::XML::Builder.new(:encoding => "UTF-8") do |xml|
        xml.nome nome
      end.to_xml
    end

    private
      def valid_attr
        [ :nome, :login_moip, :pagador_id, :email, :telefone_celular,
          :apelido, :identidade ]
      end
  end
end