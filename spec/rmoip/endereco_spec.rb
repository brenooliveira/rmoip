# encoding: utf-8

require "spec_helper"

describe Rmoip::Endereco do

  let :endereco do
    Rmoip::Endereco.new do
      logradouro "Rua dos bobos"
      numero "0"
      complemento "Ap -1"
      bairro "Bairro"
      cidade "São Paulo"
      estado "SP"
      pais "Brasil"
      cep "01234-567"
      telefone_fixo "(11) 2345-6789"
    end
  end

  context "cria um Endereco" do

    it "com logradouro" do
      endereco.logradouro.should eq "Rua dos bobos"
    end

    it "com numero" do
      endereco.numero.should eq "0"
    end

    it "com complemento" do
      endereco.complemento.should eq "Ap -1"
    end

    it "com bairro" do
      endereco.bairro.should eq "Bairro"
    end

    it "com cidade" do
      endereco.cidade.should eq "São Paulo"
    end

    it "com estado" do
      endereco.estado.should eq "SP"
    end

    it "com pais" do
      endereco.pais.should eq "Brasil"
    end

    it "com CEP" do
      endereco.cep.should eq "01234-567"
    end

    it "com telefone fixo" do
      endereco.telefone_fixo.should eq "(11) 2345-6789"
    end

  end

  describe "#to_xml" do

    let :expected_xml  do
      expected.remove_spaces
    end

    context "xml completo" do

      let :expected do
        <<-XML
<EnderecoCobranca>
  <Logradouro>Rua dos bobos</Logradouro>
  <Numero>0</Numero>
  <Complemento>Ap -1</Complemento>
  <Bairro>Bairro</Bairro>
  <Cidade>São Paulo</Cidade>
  <Estado>SP</Estado>
  <Pais>Brasil</Pais>
  <CEP>01234-567</CEP>
  <TelefoneFixo>(11) 2345-6789</TelefoneFixo>
</EnderecoCobranca>
        XML
      end

      it "cria o xml" do
        endereco.to_xml.should eq expected_xml
      end


    end

  end

end
