# frozen_string_literal: true

CIPHER = <<-EOF

####.###..#....#..#.###..###..####.#..#
#....#..#.#....#..#.#..#.#..#.#....#..#
###..###..#....#..#.###..#..#.###..####
#....#..#.#....#..#.#..#.###..#....#..#
#....#..#.#....#..#.#..#.#.#..#....#..#
####.###..####..##..###..#..#.#....#..#
EOF

describe Tasks::Day13::Run do
  describe '#call1' do
    it { expect(described_class.new.call1).to eq(708) }
  end

  describe '#call2' do
    it { expect(described_class.new.call2).to eq(CIPHER.rstrip) }
  end
end
