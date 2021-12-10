# frozen_string_literal: true

describe Tasks::Day10::Run do
  describe '#call1' do
    it { expect(described_class.new.call1).to eq(216297) }
  end

  describe '#call2' do
    it { expect(described_class.new.call2).to eq(2165057169) }
  end
end
