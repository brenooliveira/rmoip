require "spec_helper"

describe Rmoip::Request do

  let(:request) { described_class.new "ABCDEF", "GHIJKL", :sandbox }

  describe "#send_instrucao_unica" do

    let(:response) do
      request.send_instrucao_unica do
        razao "Razão / Motivo do pagamento"
        id_proprio "ABC1234"
        # valores do
          valor 1.00
        # end
      end
    end

    context "sucesso" do
      it "envia InstrucaoUnica minima" do
        VCR.use_cassette("instrucao_minima") do
          response.should be_success
        end
      end
    end

    context "quando ID proprio já foi utilizado" do

      let(:subject) do
        VCR.use_cassette("instrucao_minima_id_proprio_ja_utilizado") do
          response
        end
      end

      it { should_not be_success }

      it { subject.errors.should include({
        "Codigo" => "102",
        "Mensagem" => "Id Próprio já foi utilizado em outra Instrução"
      }) }

    end

  end

end
