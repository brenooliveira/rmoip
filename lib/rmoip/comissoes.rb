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

    def to_xml(builder)
      builder.Comissionamento do |comissionamento|
        @comissionados.each do |c|
          comissionamento.Comissionado do |comissionado|
            comissionado.LoginMoIP c.comissionado
          end

          comissionamento.Razao c.razao
          comissionamento.ValorFixo c.valor_fixo if c.valor_fixo
          comissionamento.ValorPercentual c.valor_percentual if c.valor_percentual
        end
      end
    end

  end
end
