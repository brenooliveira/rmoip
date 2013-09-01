require "spec_helper"

describe Rmoip::NASP do

  let(:nasp_example) do
    {
      :id_transacao => "abc.1234",
      :valor => "100",
      :status_pagamento => "5",
      :cod_moip => "12345678",
      :forma_pagamento => "3",
      :tipo_pagamento => "CartaoDeCredito",
      :parcelas => "1",
      :email_consumidor => "pagador@email.com.br",
      :classificacao => "Solicitado pelo vendedor"
    }
  end

  let(:subject) { described_class.new nasp_example }

  it { should be_canceled }

  it { subject.id_transacao.should eq "abc.1234" }

end
