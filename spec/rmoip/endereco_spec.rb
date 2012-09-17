# encoding: utf-8

require "spec_helper"

describe Rmoip::Endereco do

  context "cria um Endereco" do
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

end