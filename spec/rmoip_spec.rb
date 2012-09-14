# encoding: utf-8
require "spec_helper"

describe Rmoip do

  describe "ao enviar pagamentos para o moip atraves da api" do
    describe "ao tentar enviar a intrucao" do
      describe "ao tentar me autenticando com o moip" do
        before do
          @request = Rmoip.sandbox("01010101010101010101010101010101","ABABABABABABABABABABABABABABABABABABABAB")
        end
        it ("deve devolver uma  instancia para sandbox") do
          @request.should_not be_nil
        end
        it ("deve ter um token") do
          @request.token.should eq "01010101010101010101010101010101"
        end
        it ("deve ter uma key") do
          @request.key.should eq "ABABABABABABABABABABABABABABABABABABABAB"
        end

      end

      context "quando validamos a instrucao" do
        it ("deve ter um id_propio informado") do
          @cobranca = {
                        :valor => "8.90",
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

            expect { 
                  Rmoip.sandbox("01010101010101010101010101010101","ABABABABABABABABABABABABABABABABABABABAB")
                          .send(@cobranca).validate()
             }.to raise_error(Rmoip::MissingIdProprioError)
        end
        it ("deve ter uma razao do pagamento") do
          cobranca = {
                        :valor => "8.90",
                        :id_proprio => "qualquer_um"
                      }

          expect { 
                  Rmoip.sandbox("01010101010101010101010101010101","ABABABABABABABABABABABABABABABABABABABAB")
                          .send(cobranca).validate()
             }.to raise_error(Rmoip::MissingRazaoError)
        end
        it ("deve ter um valor maior que 0") do
            cobranca = {
                        :valor => "0",
                        :id_proprio => "qualquer_um",
                        :razao => "Qualquer motivo"
                      }

            expect { 
                  Rmoip.sandbox("01010101010101010101010101010101","ABABABABABABABABABABABABABABABABABABABAB")
                          .send(cobranca).validate()
             }.to raise_error(Rmoip::InvalidBillValue)
        end
        
        context "quando tem comissionado" do
          it ("deve ter um Comissionado com LoginMoip") do
            comissionado = {
              :razao => "Uma divisao para qualquer",
              :valor_fixo => 2.50,
              :mostrar_para_pagador => true
            }

            expect { 
                  Rmoip.sandbox("01010101010101010101010101010101","ABABABABABABABABABABABABABABABABABABABAB")
                          .add_split(comissionado)
             }.to raise_error(Rmoip::MissingLoginMoip)
          end
          it ("deve ter um valor fixo ou percentual") do
            comissionado = {
              :razao => "Uma divisao para qualquer",
              :login_moip => "breno.oliveira",
              :mostrar_para_pagador => true
            }

            expect { 
                  Rmoip.sandbox("01010101010101010101010101010101","ABABABABABABABABABABABABABABABABABABABAB")
                          .add_split(comissionado)
             }.to raise_error(Rmoip::InvalidComissionValue)
          end
        end

        context "quando tem opcoes de parcelamento" do
          it ("deve ter um minimo de parcelas") do
            @parcel = {
                    :min => -1,
                    :max => 5,
                    :juros => 2.99,
                    :repassar => true
                 }

            expect { 
                  Rmoip.sandbox("01010101010101010101010101010101","ABABABABABABABABABABABABABABABABABABABAB")
                          .add_parcel(@parcel)
             }.to raise_error(Rmoip::InvalidMinValue)
          end
          it ("deve ter um maximo de parcelas") do
            @parcel = {
                    :min => 1,
                    :max => 120,
                    :juros => 2.99,
                    :repassar => true
                 }
            expect {
                  Rmoip.sandbox("01010101010101010101010101010101","ABABABABABABABABABABABABABABABABABABABAB")
                          .add_parcel(@parcel)
              }.to raise_error(Rmoip::InvalidMaxValue)
          end
          it ("deve ter juros informado") do
            parcel = {
                    :min => 1,
                    :max => 12,
                    :repassar => true
                 }
            expect {
                  Rmoip.sandbox("01010101010101010101010101010101","ABABABABABABABABABABABABABABABABABABABAB")
                          .add_parcel(parcel)
              }.to raise_error(Rmoip::MissingJurosError)
          end
        end
      end
    end
  end
end
