# encoding: utf-8
#require "rubygems"
#require "spec_helper"
require "rmoip"

describe Rmoip do
  
  #before :all do
  #  Rmoip.config do |config|
  #    config.env = :SANDBOX
  #    config.token = ""
  #    config.key = ""
  #  end
  #end

  describe "ao enviar pagamentos para o moip atraves da api" do
    describe "ao tentar enviar a intrucao" do
      describe "ao tentar me autenticando com o moip" do
        it ("deve ter um token")
        it ("deve ter uma key")
      end
    
      context "quando validamos a instrucao" do
        it ("deve ter um id_propio informado")
        it ("deve ter uma razao do pagamento")
        it ("deve ter um valor maior que 0")
        context "quando tem comissionado" do
          it ("deve ter um Comissionado com LoginMoip")
          it ("deve ter um valor fixo ou percentual")
        end
        context "quando tem opcoes de parcelamento" do
          it ("deve ter um minimo de parcelas")
          it ("deve ter um maximo de parcelas")
          it ("deve ter juros informado")
        end
      end
    end
  end
end
