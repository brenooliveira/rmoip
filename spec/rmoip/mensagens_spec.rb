# encoding: utf-8

require "spec_helper"

describe  Rmoip::Mensagens do
  let :mensagens do
    described_class.new do
      mensagem "Produto adquirido no site ABC"
      mensagem "Total pago + frete - Preço: R$40,10"
    end
  end

  context "cria" do
    it "com duas mensagens" do
      mensagens.size.should eq 2
    end
  end

  context "#include?" do
    it "verifica se mensagem existe" do
      mensagens.include? "Produto adquirido no site ABC"
    end
  end
end