module Rmoip
  class Pagador
    include Commons

    def endereco_cobranca(&block)
      @endereco_cobranca ||= Endereco.new &block
    end

    def to_xml(*args)
      if args.size == 1
        xml = args.first

        xml.Nome nome
        xml.LoginMoip login_moip
      end
      # TODO precisa implementar quando o builder nao recebe nenhum parametro?
=begin
      Nokogiri::XML::Builder.new(:encoding => "UTF-8") do |xml|
        xml.Pagador {
          xml.nome nome
          xml.LoginMoip login_moip
        }
      end.to_xml(:save_with => Nokogiri::XML::Node::SaveOptions::NO_DECLARATION)
=end
    end

    private
      def valid_attr
        [ :nome, :login_moip, :pagador_id, :email, :telefone_celular,
          :apelido, :identidade ]
      end
  end
end
