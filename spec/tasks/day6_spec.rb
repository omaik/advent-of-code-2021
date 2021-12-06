# frozen_string_literal: true

describe Tasks::Day6::Run do
  describe '#call1' do
    it { expect(described_class.new.call1).to eq(379_414) }
  end

  describe '#call2' do
    it { expect(described_class.new.call2).to eq(1_705_008_653_296) }
  end
end
