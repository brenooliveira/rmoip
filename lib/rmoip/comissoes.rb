module Rmoip
  class Comissoes
    def initialize(&block)
      @comissionados = []

      instance_eval &block if block_given?
    end

    def size
      @comissionados.size
    end

    def add(*args, &block)
      @comissionados << Comissao.new(&block) if block_given?
      @comissionados << args.first unless args.empty?
    end

    def to_xml
      Builder::XmlMarkup.new(:indent => 2).Comissoes do |xml|
        @comissionados.each do |c|
          xml.Comissionamento do
            xml.Comissionado do
              xml.LoginMoIP c.comissionado
            end

            xml.Razao c.razao
            xml.ValorFixo c.valor_fixo if c.valor_fixo
            xml.ValorPercentual c.valor_percentual if c.valor_percentual
          end
        end
      end
    end

  end
end
