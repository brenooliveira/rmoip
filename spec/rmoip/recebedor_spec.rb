require "spec_helper"

describe Rmoip::Recebedor do

  let :recebedor do
    described_class.new do
      login_moip "login_recebedor"
      apelido "apelido recebedor"
    end
  end

  context "cria um recebedor" do
    it "com login_moip" do
      recebedor.login_moip.should eq "login_recebedor"
    end

    it "com apelido" do
      recebedor.apelido.should eq "apelido recebedor"
    end
  end

  describe "#to_xml" do

    let(:subject) { recebedor.to_xml }

    it { should eq "<Recebedor><LoginMoIP>login_recebedor</LoginMoIP><Apelido>apelido recebedor</Apelido></Recebedor>" }

  end

end
