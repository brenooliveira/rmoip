# encoding: utf-8

require "spec_helper"

class TestCommons
  include Rmoip::Commons
end

describe Rmoip::Commons do
  context "quando valid_attr não é implementado" do
    let(:commons) { TestCommons.new {} }

    it "raise NoMethodError for valid_attr" do
      expect {
        commons.algum_atributo
      }.to raise_error(NoMethodError, "Method valid_attr must be implemented")
    end
  end

  context "#initialize sem passar block" do
    let(:commons) { TestCommons.new }

    it "cria um objeto" do
      commons.should_not be_nil
    end
  end
end