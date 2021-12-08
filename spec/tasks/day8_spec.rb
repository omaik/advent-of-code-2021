# frozen_string_literal: true

describe Tasks::Day8::Run do
  describe '#call1' do
    it { expect(described_class.new.call1).to eq(274) }
  end

  describe '#call2' do
    it { expect(described_class.new.call2).to eq(1_012_089) }
  end
end
