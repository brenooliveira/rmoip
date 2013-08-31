module Rmoip
  class Mensagens

    attr_reader :mensagens

    def initialize(&block)
      @mensagens = []

      instance_eval &block if block_given?
    end

    def mensagem(msg)
      @mensagens << msg
    end

    def size
      @mensagens.size
    end

    def include?(msg)
      @mensagens.include? msg
    end

    def to_xml
      Builder::XmlMarkup.new.Mensagens do |xml|
        mensagens.each do |msg|
          xml.Mensagem msg
        end
      end
    end
  end
end
