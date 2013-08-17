# encoding: utf-8

require "spec_helper"

describe  Rmoip::Mensagens do
  let :mensagens do
    described_class.new do
      mensagem "Produto adquirido no site ABC"
      mensagem "Total pago + frete - Preço: R$40,10"
    end
  end

  describe "cria" do
    it "com duas mensagens" do
      mensagens.size.should eq 2
    end
  end

  describe "#include?" do
    it "verifica se mensagem existe" do
      mensagens.include? "Produto adquirido no site ABC"
    end
  end

  describe "#to_xml" do
    let(:subject) { mensagens.to_xml }

    it { should eq %(
<Mensagens>
  <Mensagem>Produto adquirido no site ABC</Mensagem>
  <Mensagem>Total pago + frete - Preço: R$40,10</Mensagem>
</Mensagens>).remove_spaces}
  end
end
