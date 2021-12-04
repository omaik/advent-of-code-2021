# frozen_string_literal: true

describe Tasks::Day4::Run do
  describe '#call1' do
    it { expect(described_class.new.call1).to eq(39_902) }
  end

  describe '#call2' do
    it { expect(described_class.new.call2).to eq(26_936) }
  end
end
