module Rmoip
  class Parcelamento
    include Commons

    def parcelamento(&block)
      @parcelmento ||= Parcelamento.new &block
    end

    def to_xml
      Nokogiri::XML::Builder.new(:encoding => "UTF-8") do |xml|
        xml.MinimoParcelas min
        xml.MaximoParcelas max
        xml.Juros interest
        xml.Repassar transfer 
      end.to_xml
    end

    private
      def valid_attr
        [ :min, :max, :interest, :transfer ]
      end
  end
end