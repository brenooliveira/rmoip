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
  end

  context "#to_xml" do
    it "cria um xml" do
      instrucao_unica.to_xml.should eq <<-XML
<?xml version="1.0" encoding="UTF-8"?>
<EnviarInstrucao>
  <InstrucaoUnica>
    <Razao>uma razao qualquer</Razao>
    <payer>
      <Nome>Pagador Moip</Nome>
    </payer>
  </InstrucaoUnica>
</EnviarInstrucao>
      XML
    end
  end


end