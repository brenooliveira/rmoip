module Rmoip
  class Parcelamento
    include Commons

    def parcelamento(&block)
      @parcelmento ||= Parcelamento.new &block
    end

    def to_xml
    end

    private
      def valid_attr
        [ :min, :max, :interest, :transfer ]
      end
  end
end