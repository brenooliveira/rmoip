require "spec_helper"

describe Rmoip::Comissoes do
  describe "#add" do
    context "passando um block" do
      let :comissoes do
        described_class.new do
          add do
            comissionado "login_comissionado"
            razao "uma razao para comisao"
          end
        end
      end

      it "adiciona um comissionado" do
        comissoes.size.should eq 1
      end
    end

    context "passando comissionado por parametro" do
      let(:comissoes) { described_class.new }
      let :comissao do
        Rmoip::Comissao.new do
          comissionado "login_comissionado"
        end
      end

      before do
        comissoes.add comissao
      end

      it "adiciona um comisionado" do
        comissoes.size.should eq 1
      end
    end
  end

  describe "#size" do
    let(:comissoes) { described_class.new }

    it "retorna a quantidade de comissoes" do
      comissoes.size.should eq 0
    end
  end
end
