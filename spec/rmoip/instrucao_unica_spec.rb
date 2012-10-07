# encoding: utf-8

require "spec_helper"

describe Rmoip::InstrucaoUnica do

  let(:instrucao_unica) { described_class.new }

  describe "#pagador" do
    let(:pagador) do
      p = Rmoip::Pagador.new
      p.nome "Pagador Moip"
      p
    end

    context "passando block" do
      let(:instrucao_unica) do
        described_class.new do
          pagador do
            nome "Pagador Moip"
          end
        end
      end

      it "cria pagador" do
        instrucao_unica.pagador.nome.should eq "Pagador Moip"
      end
    end

    context "passando parametro" do
      before  do
        instrucao_unica.pagador pagador
      end

      it "set pagador" do
        instrucao_unica.pagador.should equal pagador
      end
    end

    context "sem parametros" do
      context "quando nenhum pagador foi adicionado" do
        it "retorna nil" do
          instrucao_unica.pagador.should be_nil
        end
      end

      context "quando um pagador foi adicionado" do
        before { instrucao_unica.pagador pagador }

        it "retorna o pagador criado" do
          instrucao_unica.pagador.should equal pagador
        end
      end
    end
  end

  describe "#recebedor" do
    let(:recebedor) do
      Rmoip::Recebedor.new do
        login_moip "recebedor_login"
      end
    end

    context "passando block" do
      let(:instrucao_unica) do
        described_class.new do
          recebedor do
            login_moip "recebedor_login"
          end
        end
      end

      it "cria recebedor" do
        instrucao_unica.recebedor.login_moip.should eq "recebedor_login"
      end
    end

    context "passando parametro" do
      before  do
        instrucao_unica.recebedor recebedor
      end

      it "set recebedor" do
        instrucao_unica.recebedor.should equal recebedor
      end
    end

    context "sem parametros" do
      context "quando nenhum recebedor foi adicionado" do
        it "retorna nil" do
          instrucao_unica.recebedor.should be_nil
        end
      end

      context "quando um recebedor foi adicionado" do
        before { instrucao_unica.recebedor recebedor }

        it "retorna o pagador criado" do
          instrucao_unica.recebedor.should equal recebedor
        end
      end
    end
  end

  describe "#formas_pagamento" do
    let :formas_pagamento do
      Rmoip::FormasPagamento.new do
        boleto_bancario
      end
    end

    context "passando block" do
      let :instrucao_unica do
        described_class.new do
          formas_pagamento do
            carteira_moip
          end
        end
      end

      it "cria formas_pagamento" do
        instrucao_unica.formas_pagamento.should include :carteira_moip
      end
    end

    context "passando parametro" do
      before do
        instrucao_unica.formas_pagamento formas_pagamento
      end

      it "set formas_pagamento" do
        instrucao_unica.formas_pagamento.should include :boleto_bancario
      end
    end

    context "sem parametro" do
      context "quando nenhum recebedor foi adicionado" do
        it "retorna nil" do
          instrucao_unica.formas_pagamento.should be_nil
        end
      end

      context "quando um recebedor foi adicionado" do
        before { instrucao_unica.formas_pagamento formas_pagamento }

        it "retorna o pagador criado" do
          instrucao_unica.formas_pagamento.should equal formas_pagamento
        end
      end
    end
  end

  describe "#mensagens" do
    let :mensagens do
      Rmoip::Mensagens.new do
        mensagem "Produto adquirido no site ABC"
        mensagem "Total pago + frete - Preço: R$40,10"
      end
    end

    context "passando block" do
      let :instrucao_unica do
        described_class.new do
          mensagens do
            mensagem "Uma mensagem"
          end
        end
      end

      it "cria mensagens" do
        instrucao_unica.mensagens.should include "Uma mensagem"
      end
    end

    context "passando parametro" do
      before do
        instrucao_unica.mensagens mensagens
      end

      it "set formas_pagamento" do
        instrucao_unica.mensagens.should include "Produto adquirido no site ABC"
      end
    end

    context "sem parametro" do
      context "quando nenhum recebedor foi adicionado" do
        it "retorna nil" do
          instrucao_unica.mensagens.should be_nil
        end
      end

      context "quando um recebedor foi adicionado" do
        before { instrucao_unica.mensagens mensagens }

        it "retorna o pagador criado" do
          instrucao_unica.mensagens.should equal mensagens
        end
      end
    end
  end

  describe "#comissoes" do
    context "passando block" do
      let :instrucao_unica do
        described_class.new do
          comissoes do
            add do
              comissionado "login_comissionado"
            end
          end
        end
      end

      it "cria comissoes" do
        instrucao_unica.comissoes.size.should eq 1
      end
    end

    context "passando parametro" do
      let :comissoes do
        Rmoip::Comissoes.new do
          add do
            comissionado "login_comissionado"
          end
        end
      end

      before do
        instrucao_unica.comissoes comissoes
      end

      it "set comissoes" do
        instrucao_unica.comissoes.should equal(comissoes)
      end
    end

    context "sem parametro" do
      let :comissoes do
        Rmoip::Comissoes.new do
          add do
            comissionado "login_comissionado"
          end
        end
      end

      context "quando comissoes nao foi setado" do
        it "retorna nil" do
          instrucao_unica.comissoes.should be_nil
        end
      end

      context "quando comissoes foi setado" do
        before { instrucao_unica.comissoes comissoes }

        it "retorna comissoes" do
          instrucao_unica.comissoes.should equal comissoes
        end
      end
    end
  end

  describe "#to_xml" do
    context "instrucao unica minima" do
      let :xml do
        described_class.new do
          razao "uma razao qualquer"
          valor 12.23
        end.to_xml
      end

      it "cria xml" do
        xml.should eq <<-XML
<?xml version="1.0" encoding="UTF-8"?>
<EnviarInstrucao>
  <InstrucaoUnica>
    <Razao>uma razao qualquer</Razao>
    <Valores>
      <Valor moeda="BRL">12.23</Valor>
    </Valores>
  </InstrucaoUnica>
</EnviarInstrucao>
        XML
      end
    end

    context "instrucao unica completa" do
      let :xml do
        described_class.new do
          razao "uma razao qualquer"
          valor 12.23
          id_proprio "ABC123456789"

          comissoes do
            add do
              comissionado "recebedor_secundario"
              razao "Motivo da comissão"
              valor_fixo "10.00"
              valor_percentual "12.00"
            end
          end
        end.to_xml
      end

      it "cria xml" do
        xml.should eq <<-XML
<?xml version="1.0" encoding="UTF-8"?>
<EnviarInstrucao>
  <InstrucaoUnica>
    <Razao>uma razao qualquer</Razao>
    <Valores>
      <Valor moeda="BRL">12.23</Valor>
    </Valores>
    <IdProprio>ABC123456789</IdProprio>
<Comissoes>
  <Comissionamento>
    <Comissionado>
      <LoginMoIP>recebedor_secundario</LoginMoIP>
    </Comissionado>
    <Razao>Motivo da comissão</Razao>
    <ValorFixo>10.00</ValorFixo>
    <ValorPercentual>12.00</ValorPercentual>
  </Comissionamento>
</Comissoes>
  </InstrucaoUnica>
</EnviarInstrucao>
        XML
      end

    end
  end

# TODO criar completo
=begin
  context "completo" do

    let(:instrucao_unica) do
      described_class.new do
        razao "uma razao qualquer"
        id_proprio "ID_PROPRIO_1"
        valor 12.23

        pagador do
          nome "Pagador Moip"
          login_moip "pagador"
        end

        add_split do
          razao "Uma razao qualquer"
          valor_fixo "20.10"
        end

        url_retorno "http://meusite.com.br/"
        url_notificacao "http://meusite.com.br/notificacao/"

        recebedor do
          login_moip "recebedor_login"
        end

        formas_pagamento do
          boleto_bancario
        end

        mensagens {
          mensagem "Produto adquirido no site ABC"
        }
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

      it "com url retorno" do
        instrucao_unica.url_retorno.should eq "http://meusite.com.br/"
      end

      it "com url notificacao" do
        instrucao_unica.url_notificacao.should eq "http://meusite.com.br/notificacao/"
      end

      it "com recebedor" do
        instrucao_unica.recebedor.login_moip.should eq "recebedor_login"
      end

      it "com formas de pagamento" do
        instrucao_unica.formas_pagamento.should include :boleto_bancario
      end

      it "com mensagens" do
        instrucao_unica.mensagens.size.should eq 1
      end

    end

    context "#to_xml" do
      it "cria um xml" do
        instrucao_unica.to_xml.should eq <<-XML
  <?xml version="1.0" encoding="UTF-8"?>
  <EnviarInstrucao>
    <InstrucaoUnica>
      <Razao>uma razao qualquer</Razao>
      <Pagador>
        <Nome>Pagador Moip</Nome>
        <LoginMoip>pagador</LoginMoip>
      </Pagador>
    </InstrucaoUnica>
  </EnviarInstrucao>
        XML
      end
    end
  end
=end
end
