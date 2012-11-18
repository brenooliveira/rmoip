# encoding: utf-8

require "spec_helper"

describe Rmoip::Pagador do
  context "cria um Pagador" do
    let :pagador do
      Rmoip::Pagador.new do
        nome "Pagador Moip"
        login_moip "pagador_login"
        pagador_id "PAGADOR_ID_1"
        email "pagador@domain.com"
        telefone_celular "(11) 98888-7766"
        apelido "Apelido"
        identidade "222.222.222-22"

        endereco_cobranca do
          logradouro "Rua dos Bobos"
        end
      end
    end

    it "com nome" do
      pagador.nome.should eq "Pagador Moip"
    end

    it "com login_moip" do
      pagador.login_moip.should eq "pagador_login"
    end

    it "com id" do
      pagador.pagador_id.should eq "PAGADOR_ID_1"
    end

    it "com email" do
      pagador.email.should eq "pagador@domain.com"
    end

    it "com telefone celular" do
      pagador.telefone_celular.should eq "(11) 98888-7766"
    end

    it "com apelido" do
      pagador.apelido.should eq "Apelido"
    end

    it "com identidade" do
      pagador.identidade.should eq "222.222.222-22"
    end

    it "com endereço de cobrança" do
      pagador.endereco_cobranca.logradouro.should eq "Rua dos Bobos"
    end
  end

  describe "#to_xml" do

    let :expected_xml do
      expected.remove_spaces
    end

    context "xml minimo" do
      let :pagador do
        described_class.new do
        end
      end

      let :expected do
        <<-XML
<Pagador>
</Pagador>
        XML
      end

      it "cria xml" do
        pagador.to_xml.should eq expected_xml
      end
    end

    context "xml completo" do
      let :pagador do
        described_class.new do
          nome "Luiz Inacio Lula da Silva"
          login_moip "lula"
          email "presidente@planalto.gov.br"
          telefone_celular "(61)9999-9999"
          apelido "Lula"
          identidade "111.111.111-11"

          endereco_cobranca do
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
      end

      let :expected do
        <<-XML
<Pagador>
  <Nome>Luiz Inacio Lula da Silva</Nome>
  <LoginMoIP>lula</LoginMoIP>
  <Email>presidente@planalto.gov.br</Email>
  <TelefoneCelular>(61)9999-9999</TelefoneCelular>
  <Apelido>Lula</Apelido>
  <Identidade>111.111.111-11</Identidade>
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
</Pagador>
        XML
      end

      it "cria o xml" do
        pagador.to_xml.should eq expected_xml
      end
    end
  end
end
