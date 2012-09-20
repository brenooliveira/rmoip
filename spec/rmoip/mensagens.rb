module Rmoip
  class Mensagens

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
  end
end