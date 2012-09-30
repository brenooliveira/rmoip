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

  describe "#to_xml" do
    context "xml minimo" do
      let :comissoes do
        described_class.new do
          add do
            comissionado "login_comissionado"
            razao "uma razao para comissao"
            valor_fixo "10.00"
          end
        end
      end

      context "sem parametros" do
        let(:xml) do
          builder = Builder::XmlMarkup.new :indent => 2
          builder.Comissoes do |xml|
            comissoes.to_xml xml
          end
        end

        it "cria xml" do
          xml.should eq <<-XML
<Comissoes>
  <Comissionamento>
    <Comissionado>
      <LoginMoIP>login_comissionado</LoginMoIP>
    </Comissionado>
    <Razao>uma razao para comissao</Razao>
    <ValorFixo>10.00</ValorFixo>
  </Comissionamento>
</Comissoes>
          XML
        end
      end
    end

    context "xml completo" do
      let :comissoes do
        described_class.new do
          add do
            comissionado "login_comissionado"
            razao "uma razao para comissao"
            valor_fixo "10.00"
            valor_percentual "12.00"
          end
        end
      end

      context "sem parametros" do
        let(:xml) do
          builder = Builder::XmlMarkup.new :indent => 2
          builder.Comissoes do |xml|
            comissoes.to_xml xml
          end
        end

        it "cria xml" do
          xml.should eq <<-XML
<Comissoes>
  <Comissionamento>
    <Comissionado>
      <LoginMoIP>login_comissionado</LoginMoIP>
    </Comissionado>
    <Razao>uma razao para comissao</Razao>
    <ValorFixo>10.00</ValorFixo>
    <ValorPercentual>12.00</ValorPercentual>
  </Comissionamento>
</Comissoes>
          XML
        end
      end
    end
  end
end
