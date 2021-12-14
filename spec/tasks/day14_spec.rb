# frozen_string_literal: true

describe Tasks::Day14::Run do
  describe '#call1' do
    it { expect(described_class.new.call1).to eq(2509) }
  end

  describe '#call2' do
    it { expect(described_class.new.call2).to eq(2_827_627_697_643) }
  end
end
