describe Tasks::Day18::God do
  describe '#explode' do
    it { expect(described_class.new([[[[[9, 8], 1], 2], 3], 4]).explode.to_a).to eq([[[[0, 9], 2], 3], 4]) }
    it { expect(described_class.new([7, [6, [5, [4, [3, 2]]]]]).explode.to_a).to eq([7, [6, [5, [7, 0]]]]) }
    it { expect(described_class.new([[6, [5, [4, [3, 2]]]], 1]).explode.to_a).to eq([[6, [5, [7, 0]]], 3]) }
    it { expect(described_class.new([[6, [5, [4, [3, 2]]]], 1]).explode.to_a).to eq([[6, [5, [7, 0]]], 3]) }
    it { expect(described_class.new([[3, [2, [1, [7, 3]]]], [6, [5, [4, [3, 2]]]]]).explode.to_a).to eq([[3, [2, [8, 0]]], [9, [5, [4, [3, 2]]]]]) }
  end
end
