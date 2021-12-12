# frozen_string_literal: true

describe Tasks::Day12::Run do
  describe '#call1' do
    it { expect(described_class.new.call1).to eq(3563) }
  end

  describe '#call2' do
    it { expect(described_class.new.call2).to eq(105_453) }
  end
end
