# encoding: utf-8

require "spec_helper"

describe Rmoip::InstrucaoUnica do

  let(:instrucao_unica) do
    described_class.new do
      razao "uma razao qualquer"
      id_proprio "ID_PROPRIO_1"
      valor 12.23

      pagador do
        nome "Pagador Moip"
        login_moip "pagador"
      end

      add_split do
        razao "Uma razao qualquer"
        valor_fixo "20.10"
      end

      url_retorno "http://meusite.com.br/"
      url_notificacao "http://meusite.com.br/notificacao/"

      recebedor do
        login_moip "recebedor_login"
      end

      formas_pagamento do
        boleto_bancario
      end
    end
  end

  context "cria uma InstrucaoUnica" do
    it "válida" do
      instrucao_unica.should be_valid
    end

    it "com razao" do
      instrucao_unica.razao.should eq "uma razao qualquer"
    end

    it "com id_proprio" do
      instrucao_unica.id_proprio.should eq "ID_PROPRIO_1"
    end

    it "com valor" do
      instrucao_unica.valor.should eq "12.23"
    end

    it "com pagador" do
      instrucao_unica.pagador.nome.should eq "Pagador Moip"
    end

    it "com url retorno" do
      instrucao_unica.url_retorno.should eq "http://meusite.com.br/"
    end

    it "com url notificacao" do
      instrucao_unica.url_notificacao.should eq "http://meusite.com.br/notificacao/"
    end

    it "com recebedor" do
      instrucao_unica.recebedor.login_moip.should eq "recebedor_login"
    end

    it "com formas de pagamento" do
      instrucao_unica.formas_pagamento.should include :boleto_bancario
    end

  end

  context "#to_xml" do
    it "cria um xml" do
      instrucao_unica.to_xml.should eq <<-XML
<?xml version="1.0" encoding="UTF-8"?>
<EnviarInstrucao>
  <InstrucaoUnica>
    <Razao>uma razao qualquer</Razao>
    <Pagador>
      <Nome>Pagador Moip</Nome>
      <LoginMoip>pagador</LoginMoip>
    </Pagador>
  </InstrucaoUnica>
</EnviarInstrucao>
      XML
    end
  end


end
