# frozen_string_literal: true

describe Tasks::Day15::Run do
  describe '#call1' do
    it { expect(described_class.new.call1).to eq(619) }
  end

  describe '#call2' do
    it { expect(described_class.new.call2).to eq(2922) }
  end
end
