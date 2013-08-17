module Rmoip
  class Boleto
    include Commons

    def data_vencimento(date = nil)
      if date
        @params[:date] = date
      end
      @params[:date]
    end

    def to_xml
      Builder::XmlMarkup.new.Boleto do |xml|
        xml.DataVencimento data_vencimento.strftime('%FT12:00:00.000-03:00') if data_vencimento
        xml.Instrucao1 instrucao_1 if instrucao_1
        xml.Instrucao2 instrucao_2 if instrucao_2
        xml.Instrucao3 instrucao_3 if instrucao_3
        xml.URLLogo url_logo if url_logo
      end
    end

    private
    def valid_attr
      [ :data_vencimento, :instrucao_1, :instrucao_2, :instrucao_3, :url_logo ]
    end
  end
end
