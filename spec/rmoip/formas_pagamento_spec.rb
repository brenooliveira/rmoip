require "spec_helper"

describe Rmoip::FormasPagamento do
  let :formas_pagamento do
    described_class.new do
      boleto_bancario
      carteira_moip
      cartao_credito
      debito_bancario
      financiamento_bancario
    end
  end

  describe "cria" do
    it "com boleto bancario" do
      formas_pagamento.should include :boleto_bancario
    end

    it "com carteira moip" do
      formas_pagamento.should include :carteira_moip
    end

    it "com cartao credito" do
      formas_pagamento.should include :cartao_credito
    end

    it "com debito bancario" do
      formas_pagamento.should include :debito_bancario
    end

    it "com financiamento bancario" do
      formas_pagamento.should include :financiamento_bancario
    end
  end

  describe "#remove" do
    before { formas_pagamento.remove :boleto_bancario }

    it "remove forma de pagamento" do
      formas_pagamento.should_not include :boleto_bancario
    end
  end

  describe "#<<" do
    context "quando forma ja existe" do
      it "raise error" do
        expect {
          formas_pagamento << :boleto_bancario
        }.to raise_error("Forma de pagamento ja adicionada")
      end
    end

    context "quando forma de pagamento nao existe" do
      before do
        formas_pagamento.remove :boleto_bancario
        formas_pagamento << :boleto_bancario
      end

      it "adiciona forma de pagamento" do
        formas_pagamento.should include :boleto_bancario
      end
    end

    context "quando tenta adicionar uma forma de pagamento invalida" do
      it "raises error" do
        expect {
          formas_pagamento << :forma_invalida
        }.to raise_error("Forma de pagamento invalida")
      end
    end
  end

  describe "#to_xml" do
    let(:subject) { formas_pagamento.to_xml }

    it { should eq %(
<FormasPagamento>
  <FormaPagamento>BoletoBancario</FormaPagamento>
  <FormaPagamento>CarteiraMoip</FormaPagamento>
  <FormaPagamento>CartaoCredito</FormaPagamento>
  <FormaPagamento>DebitoBancario</FormaPagamento>
  <FormaPagamento>FinanciamentoBancario</FormaPagamento>
</FormasPagamento>).remove_spaces }
  end

end
