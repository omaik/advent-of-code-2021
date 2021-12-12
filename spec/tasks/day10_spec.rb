# frozen_string_literal: true

describe Tasks::Day10::Run do
  describe '#call1' do
    it { expect(described_class.new.call1).to eq(216_297) }
  end

  describe '#call2' do
    it { expect(described_class.new.call2).to eq(2_165_057_169) }
  end
end
