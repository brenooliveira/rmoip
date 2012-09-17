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
end