# frozen_string_literal: true

describe Tasks::Day7::Run do
  describe '#call1' do
    it { expect(described_class.new.call1).to eq(348_664) }
  end

  describe '#call2' do
    it { expect(described_class.new.call2).to eq(100_220_525) }
  end
end
