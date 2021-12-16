# frozen_string_literal: true

describe Tasks::Day16::Run do
  describe '#call1' do
    it { expect(described_class.new.call1).to eq(893) }
  end

  describe '#call2' do
    it { expect(described_class.new.call2).to eq(4_358_595_186_090) }
  end
end
