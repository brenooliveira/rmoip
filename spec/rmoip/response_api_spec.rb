require "spec_helper"

describe Rmoip::ResponseApi do

  let(:response_api) {
    described_class.new({
      "ID" => "201308171216268470000004086587",
      "Status" => "Sucesso",
      "Token" => "Y26051I3N0U871W721B2T1U6Z2Q6J8N4R7H0L0T0V0O0R0M4C078U6G5S8D7"
    }, "https://desenvolvedor.moip.com.br/sandbox")
  }

  describe "#id" do
    it { response_api.id.should eq "201308171216268470000004086587" }
  end


  describe "#success?" do
    it { response_api.should be_success }
  end

  describe "#token" do
    it { response_api.token.should eq "Y26051I3N0U871W721B2T1U6Z2Q6J8N4R7H0L0T0V0O0R0M4C078U6G5S8D7" }
  end

  context "quando erro" do

    let(:subject) do
      described_class.new({
        "ID" => "201308171216268470000004086587",
        "Status" => "Falha",
        "Erro" => {
          "__content__" => "Id Próprio já foi utilizado em outra Instrução",
          "Codigo" => "102"
        }
      }, "https://desenvolvedor.moip.com.br/sandbox")
    end

    it { should_not be_success }

  end

end
