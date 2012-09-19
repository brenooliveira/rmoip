# encoding: utf-8

require "spec_helper"

describe Rmoip::Parcelamento do

  context "Cria uma parcela" do
    let :parcelamento do
      Rmoip::Parcelamento.new do
        min "5"
        max "10"
        interest "2.99"
        transfer "true"
      end
    end

    it "com valor minimo" do
      parcelamento.min.should eq "5"
    end

    it "com o valor maximo" do
      parcelamento.max.should eq "10"
    end

    it "com juros" do
      parcelamento.interest.should eq "2.99"
    end

    it "com o repasse" do
      parcelamento.transfer.should eq "true"
    end
  end
end