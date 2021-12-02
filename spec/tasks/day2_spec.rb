# frozen_string_literal: true

describe Tasks::Day2::Run do
  describe '#call1' do
    it { expect(described_class.new.call1).to eq(2_120_749) }
  end

  describe '#call2' do
    it { expect(described_class.new.call2).to eq(2_138_382_217) }
  end
end
