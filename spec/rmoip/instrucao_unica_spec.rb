# encoding: utf-8

require "spec_helper"

describe Rmoip::InstrucaoUnica do

  let(:instrucao_unica) { described_class.new }

  describe "#pagador" do
    let(:pagador) do
      Rmoip::Pagador.new.tap do |p|
        p.nome "Pagador Moip"
      end
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

      let :expected_xml do
        <<-XML
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

      it "cria xml" do
        xml.should eq expected_xml.remove_spaces
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

          recebedor do
            login_moip "recebedor_primario"
            apelido "Nome fantasia"
          end

          pagador do
            nome "Cliente Sobrenome"
            email "login@meudominio.com.br"
            id_pagador "login@meudominio.com.br"
            endereco_cobranca do
              logradouro "Av. Brigadeiro Faria Lima"
              numero "2927"
              complemento "8° Andar"
              bairro "Jardim Paulistano"
              cidade "Sao Paulo"
              estado "SP"
              pais "BRA"
              cep "01452-000"
              telefone_fixo "(11)3165-4020"
            end
          end

          formas_pagamento do
            cartao_credito
            debito_bancario
            financiamento_bancario
            boleto_bancario
          end

          mensagens do
            mensagem "Mensagem adicional"
          end

          boleto do
            data_vencimento Date.parse("2000-12-31")
            instrucao_1 "Primeira linha de mensagem adicional"
            instrucao_2 "Segunda linha"
            instrucao_3 "Terceira linha"
            url_logo "http://meusite.com.br/meulogo.jpg"
          end

          url_notificacao "http://meusite.com.br/notificacao/"
          url_retorno "http://meusite.com.br/"
        end.to_xml
      end

      let :expected_xml do
        <<-XML
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
    <Recebedor>
      <LoginMoIP>recebedor_primario</LoginMoIP>
      <Apelido>Nome fantasia</Apelido>
    </Recebedor>
    <Pagador>
      <Nome>Cliente Sobrenome</Nome>
      <Email>login@meudominio.com.br</Email>
      <IdPagador>login@meudominio.com.br</IdPagador>
      <EnderecoCobranca>
        <Logradouro>Av. Brigadeiro Faria Lima</Logradouro>
        <Numero>2927</Numero>
        <Complemento>8° Andar</Complemento>
        <Bairro>Jardim Paulistano</Bairro>
        <Cidade>Sao Paulo</Cidade>
        <Estado>SP</Estado>
        <Pais>BRA</Pais>
        <CEP>01452-000</CEP>
        <TelefoneFixo>(11)3165-4020</TelefoneFixo>
      </EnderecoCobranca>
    </Pagador>
    <FormasPagamento>
      <FormaPagamento>CartaoCredito</FormaPagamento>
      <FormaPagamento>DebitoBancario</FormaPagamento>
      <FormaPagamento>FinanciamentoBancario</FormaPagamento>
      <FormaPagamento>BoletoBancario</FormaPagamento>
    </FormasPagamento>
    <Mensagens>
      <Mensagem>Mensagem adicional</Mensagem>
    </Mensagens>
    <Boleto>
      <DataVencimento>2000-12-31T12:00:00.000-03:00</DataVencimento>
      <Instrucao1>Primeira linha de mensagem adicional</Instrucao1>
      <Instrucao2>Segunda linha</Instrucao2>
      <Instrucao3>Terceira linha</Instrucao3>
      <URLLogo>http://meusite.com.br/meulogo.jpg</URLLogo>
    </Boleto>
    <URLNotificacao>http://meusite.com.br/notificacao/</URLNotificacao>
    <URLRetorno>http://meusite.com.br/</URLRetorno>
  </InstrucaoUnica>
</EnviarInstrucao>
        XML
      end

      it "cria xml" do
        xml.should eq expected_xml.remove_spaces
      end

    end
  end

end
