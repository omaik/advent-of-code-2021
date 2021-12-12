# frozen_string_literal: true

describe Tasks::Day11::Run do
  describe '#call1' do
    it { expect(described_class.new.call1).to eq(1546) }
  end

  describe '#call2' do
    it { expect(described_class.new.call2).to eq(471) }
  end
end
