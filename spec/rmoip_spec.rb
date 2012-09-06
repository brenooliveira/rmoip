# encoding: utf-8
#require "rubygems"
require "spec_helper"

describe Rmoip do

  describe "ao enviar pagamentos para o moip atraves da api" do
    describe "ao tentar enviar a intrucao" do
      describe "ao tentar me autenticando com o moip" do

        it ("deve ter um token") do
          Rmoip.login("wertyuio","werwstfsdfg", :SANDBOX)
        end
        it ("deve ter uma key") do

        end

      end

      context "quando validamos a instrucao" do
        it ("deve ter um id_propio informado") do
          @cobranca = {
                        :valor => "8.90",
                        :id_proprio => "qualquer_um",
                        :razao => "Um motivo qualquer",
                        :pagador => {
                          :nome => "Luiz Inácio Lula da Silva",
                          :email => "presidente@planalto.gov.br",
                          :tel_cel => "(61)9999-9999",
                          :apelido => "Lula",
                          :identidade => "111.111.111-11",
                          :logradouro => "Praça dos Três Poderes",
                          :numero => "0",
                          :complemento => "Palácio do Planalto",
                          :bairro => "Zona Cívico-Administrativa",
                          :cidade => "Brasília",
                          :estado => "DF",
                          :pais => "BRA",
                          :cep => "70100-000",
                          :tel_fixo => "(61)3211-1221"
                        }
                      }
            @parcel1 = {
                    :min => 1,
                    :max => 5,
                    :juros => 2.99
                 }
            @parcel2 = {
                    :min => 6,
                    :max => 7,
                    :juros => 3.99
                 }
            moip = Rmoip.login("01010101010101010101010101010101","ABABABABABABABABABABABABABABABABABABABAB", :SANDBOX)
            moip.cobrar(@cobranca).enviar_cobranca 
            
        end
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
