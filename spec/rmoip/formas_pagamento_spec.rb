require "spec_helper"

describe Rmoip::FormasPagamento do
  let :forma_pagamento do
    described_class.new do
      boleto_bancario
      carteira_moip
      cartao_credito
      debito_bancario
      financiamento_bancario
    end
  end

  context "cria" do
    it "com boleto bancario" do
      forma_pagamento.should include :boleto_bancario
    end

    it "com carteira moip" do
      forma_pagamento.should include :carteira_moip
    end

    it "com cartao credito" do
      forma_pagamento.should include :cartao_credito
    end

    it "com debito bancario" do
      forma_pagamento.should include :debito_bancario
    end

    it "com financiamento bancario" do
      forma_pagamento.should include :financiamento_bancario
    end
  end

  context "#remove" do
    before { forma_pagamento.remove :boleto_bancario }

    it "remove forma de pagamento" do
      forma_pagamento.should_not include :boleto_bancario
    end
  end

  context "#<<" do
    context "quando forma ja existe" do
      it "raise error" do
        expect {
          forma_pagamento << :boleto_bancario
        }.to raise_error("Forma de pagamento ja adicionada")
      end
    end

    context "quando forma de pagamento nao existe" do
      before do
        forma_pagamento.remove :boleto_bancario
        forma_pagamento << :boleto_bancario
      end

      it "adiciona forma de pagamento" do
        forma_pagamento.should include :boleto_bancario
      end
    end

    context "quando tenta adicionar uma forma de pagamento invalida" do
      it "raises error" do
        expect {
          forma_pagamento << :forma_invalida
        }.to raise_error("Forma de pagamento invalida")
      end
    end
  end
end
