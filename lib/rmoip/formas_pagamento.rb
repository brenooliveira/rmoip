module Rmoip
  class FormasPagamento
    attr_reader :formas

    def initialize(&block)
      @formas = []

      instance_eval &block if block_given?
    end

    def <<(forma)
      raise "Forma de pagamento ja adicionada" if include? forma
      raise "Forma de pagamento invalida" unless valid_forma? forma

      @formas << forma
    end

    def include?(forma)
      @formas.include? forma
    end

    def remove(forma)
      @formas = @formas.map { |f| f != forma }
    end

    def method_missing(method, *args)
      super unless valid_forma?(method)

      self << method
    end

    def to_xml
      Builder::XmlMarkup.new.FormasPagamento do |xml|
        formas.each do |f|
          xml.FormaPagamento camelize(f.to_s)
        end
      end
    end

    private
    def valid_forma?(forma)
      valid_formas.include? forma
    end

    def valid_formas
      [ :boleto_bancario, :carteira_moip, :cartao_credito, :debito_bancario, :financiamento_bancario ]
    end

    def camelize(term)
      return term if term !~ /_/ && term =~ /[A-Z]+.*/
      term.split('_').map{|e| e.capitalize}.join
    end

  end
end
