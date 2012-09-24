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

  end
end
