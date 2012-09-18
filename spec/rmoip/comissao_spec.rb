require "spec_helper"

describe Rmoip::Comissao do
  let(:comissao) do
    described_class.new do
      razao "Razao da comissao"
      valor_percentual "30%"
      valor_fixo 3.45
      mostrar_para_payer true
      parcelada true
      comissionado "login_comissionado"
    end
  end

  context "cria" do
    it "com razao" do
      comissao.razao.should eq "Razao da comissao"
    end

    it "com valor percentual" do
      comissao.valor_percentual.should eq "30%"
    end

    it "com valor fixo" do
      comissao.valor_fixo.should eq "3.45"
    end

    it "com mostrar para payer" do
      comissao.mostrar_para_payer.should eq "true"
    end

    it "com parcelada" do
      comissao.parcelada.should eq "true"
    end

    it "com comissionado" do
      comissao.comissionado.should eq "login_comissionado"
    end


  end

end
