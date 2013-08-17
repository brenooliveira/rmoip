module Rmoip
  class Recebedor
    include Commons

    def to_xml
      Builder::XmlMarkup.new.Recebedor do |xml|
        xml.LoginMoIP login_moip
        xml.Apelido apelido
      end
    end

    private
    def valid_attr
      [ :login_moip, :apelido ]
    end
  end
end
