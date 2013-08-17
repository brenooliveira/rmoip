# encoding: utf-8
require "spec_helper"

describe Rmoip do

  TOKEN = "SOME_TOKEN"
  KEY = "SOME_KEY"

  shared_examples "returns a request" do |env|

    it { should be_a Rmoip::Request }

    it { subject.token.should eq TOKEN }

    it { subject.key.should eq KEY }

    it { subject.env.should eq env }

  end

  describe ".sandbox" do

    let(:subject) { described_class.sandbox TOKEN, KEY }

    include_examples "returns a request", :sandbox

  end

  describe ".production" do

    let(:subject) { described_class.production TOKEN, KEY }

    include_examples "returns a request", :production

  end

  # describe "ao enviar pagamentos para o moip atraves da api" do
  #   describe "ao tentar enviar a intrucao" do
  #     describe "ao tentar me autenticando com o moip" do
  #       before do
  #         @request = Rmoip.sandbox("01010101010101010101010101010101","ABABABABABABABABABABABABABABABABABABABAB")
  #       end
  #       it ("deve devolver uma  instancia para sandbox") do
  #         @request.should_not be_nil
  #       end
  #       it ("deve ter um token") do
  #         @request.token.should eq "01010101010101010101010101010101"
  #       end
  #       it ("deve ter uma key") do
  #         @request.key.should eq "ABABABABABABABABABABABABABABABABABABABAB"
  #       end

  #     end

  #     context "quando validamos a instrucao" do
  #       it ("deve ter um id_propio informado") do
  #         @cobranca = {
  #                       :value => "8.90",
  #                       :reason => "Um motivo qualquer",
  #                       :payer => {
  #                         :name => "Luiz Inácio Lula da Silva",
  #                         :email => "presidente@planalto.gov.br",
  #                         :payer_id => "um-id-qualquer",
  #                         :mobile_phone => "(61)9999-9999",
  #                         :nickname => "Lula",
  #                         :identity => "111.111.111-11",
  #                         :street => "Praça dos Três Poderes",
  #                         :number => "0",
  #                         :complement => "Palácio do Planalto",
  #                         :neighborhood => "Zona Cívico-Administrativa",
  #                         :city => "Brasília",
  #                         :state => "DF",
  #                         :country => "BRA",
  #                         :zipcode => "70100-000",
  #                         :phone => "(61)3211-1221"
  #                       }
  #                     }

  #           expect {
  #                 Rmoip.sandbox("01010101010101010101010101010101","ABABABABABABABABABABABABABABABABABABABAB")
  #                         .send(@cobranca).validate()
  #            }.to raise_error(Rmoip::MissingUniqueIdError)
  #       end
  #       it ("deve ter uma razao do pagamento") do
  #         cobranca = {
  #                       :value => "8.90",
  #                       :unique_id => "qualquer_um"
  #                     }

  #         expect {
  #                 Rmoip.sandbox("01010101010101010101010101010101","ABABABABABABABABABABABABABABABABABABABAB")
  #                         .send(cobranca).validate()
  #            }.to raise_error(Rmoip::MissingReasonError)
  #       end
  #       it ("deve ter um value maior que 0") do
  #           cobranca = {
  #                       :value => 0,
  #                       :unique_id => "qualquer_um",
  #                       :reason => "Qualquer motivo"
  #                     }

  #           expect {
  #                 Rmoip.sandbox("01010101010101010101010101010101","ABABABABABABABABABABABABABABABABABABABAB")
  #                         .send(cobranca).validate()
  #            }.to raise_error(Rmoip::InvalidValue)
  #       end

  #       context "quando tem comissionado" do
  #         it ("deve ter um Comissionado com LoginMoip") do
  #           comissionado = {
  #             :reason => "Uma divisao para qualquer",
  #             :value_fixo => 2.50,
  #             :mostrar_para_pagador => true
  #           }

  #           expect {
  #                 Rmoip.sandbox("01010101010101010101010101010101","ABABABABABABABABABABABABABABABABABABABAB")
  #                         .add_split(comissionado)
  #            }.to raise_error(Rmoip::MissingLoginMoip)
  #         end
  #         it ("deve ter um value fixo ou percentual") do
  #           comissionado = {
  #             :reason => "Uma divisao para qualquer",
  #             :login_moip => "breno.oliveira",
  #             :show_for_payer => true
  #           }

  #           expect {
  #                 Rmoip.sandbox("01010101010101010101010101010101","ABABABABABABABABABABABABABABABABABABABAB")
  #                         .add_split(comissionado)
  #            }.to raise_error(Rmoip::InvalidComissionValue)
  #         end
  #       end

  #       context "quando tem opcoes de parcelamento" do
  #         it ("deve ter um minimo de parcelas") do
  #           @parcel = {
  #                   :min => -1,
  #                   :max => 5,
  #                   :interest => 2.99,
  #                   :transfer => true
  #                }

  #           expect {
  #                 Rmoip.sandbox("01010101010101010101010101010101","ABABABABABABABABABABABABABABABABABABABAB")
  #                         .add_parcel(@parcel)
  #            }.to raise_error(Rmoip::InvalidMinValue)
  #         end
  #         it ("deve ter um maximo de parcelas") do
  #           @parcel = {
  #                   :min => 1,
  #                   :max => 120,
  #                   :interest => 2.99,
  #                   :transfer => true
  #                }
  #           expect {
  #                 Rmoip.sandbox("01010101010101010101010101010101","ABABABABABABABABABABABABABABABABABABABAB")
  #                         .add_parcel(@parcel)
  #             }.to raise_error(Rmoip::InvalidMaxValue)
  #         end
  #         it ("deve ter juros informado") do
  #           parcel = {
  #                   :min => 1,
  #                   :max => 12,
  #                   :transfer => true
  #                }
  #           expect {
  #                 Rmoip.sandbox("01010101010101010101010101010101","ABABABABABABABABABABABABABABABABABABABAB")
  #                         .add_parcel(parcel)
  #             }.to raise_error(Rmoip::MissingJurosError)
  #         end
  #       end
  #     end
  #   end
  # end
end
