# encoding: utf-8

require "spec_helper"

describe Rmoip::Boleto do
  let :boleto do
    described_class.new do
      instrucao_1 "Primeira linha de instrução de pagamento do boleto bancário"
      instrucao_2 "Segunda linha de instrução de pagamento do boleto bancário"
      instrucao_3 "Terceira linha de instrução de pagamento do boleto bancário"

      url_logo "https://desenvolvedor.moip.com.br/sandbox/imgs/logo_moip.gif"
    end
  end

  context "cria" do
    it "com instrucao 1" do
      boleto.instrucao_1.should eq "Primeira linha de instrução de pagamento do boleto bancário"
    end

    it "com instrucao 2" do
      boleto.instrucao_2.should eq "Segunda linha de instrução de pagamento do boleto bancário"
    end

    it "com instrucao 3" do
      boleto.instrucao_3.should eq "Terceira linha de instrução de pagamento do boleto bancário"
    end

    # TODO expiracao

    it "com url logo" do
      boleto.url_logo.should eq "https://desenvolvedor.moip.com.br/sandbox/imgs/logo_moip.gif"
    end
  end
end

