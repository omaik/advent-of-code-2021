# frozen_string_literal: true

describe Tasks::Day3::Run do
  describe '#call1' do
    it { expect(described_class.new.call1).to eq(3_242_606) }
  end

  describe '#call2' do
    it { expect(described_class.new.call2).to eq(4_856_080) }
  end
end
