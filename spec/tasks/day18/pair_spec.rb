describe Tasks::Day18::God do
  # describe '#explode' do
  #   it { expect(described_class.new([[[[[9, 8], 1], 2], 3], 4]).explode.to_a).to eq([[[[0, 9], 2], 3], 4]) }
  #   it { expect(described_class.new([7, [6, [5, [4, [3, 2]]]]]).explode.to_a).to eq([7, [6, [5, [7, 0]]]]) }
  #   it { expect(described_class.new([[6, [5, [4, [3, 2]]]], 1]).explode.to_a).to eq([[6, [5, [7, 0]]], 3]) }
  #   it { expect(described_class.new([[6, [5, [4, [3, 2]]]], 1]).explode.to_a).to eq([[6, [5, [7, 0]]], 3]) }
  #   it { expect(described_class.new([[3, [2, [1, [7, 3]]]], [6, [5, [4, [3, 2]]]]]).explode.to_a).to eq([[3, [2, [8, 0]]], [9, [5, [4, [3, 2]]]]]) }
  #   it { expect(described_class.new([[3, [2, [8, 0]]], [9, [5, [4, [3, 2]]]]]).explode.to_a).to eq([[3, [2, [8, 0]]], [9, [5, [7, 0]]]]) }
  # end

  describe '#reduce' do
    it { expect(described_class.new([[[[[4, 3], 4], 4], [7, [[8, 4], 9]]], [1, 1]]).reduce.to_a).to eq([[[[0, 7], 4], [[7, 8], [6, 0]]], [8, 1]]) }
    it { expect(described_class.new([[[[[4, 0], [5, 4]], [[7, 7], [6, 0]]], [[8, [7, 7]], [[7, 9], [5, 0]]]], [[2, [[0, 8], [3, 4]]], [[[6, 7], 1], [7, [1, 6]]]]]).reduce.to_a).to eq([[[[6, 7], [6, 7]], [[7, 7], [0, 7]]], [[[8, 7], [7, 7]], [[8, 8], [8, 0]]]]) }
    it { expect(described_class.new([[[[[6, 7], [6, 7]], [[7, 7], [0, 7]]], [[[8, 7], [7, 7]], [[8, 8], [8, 0]]]], [[[[2, 4], 7], [6, [0, 5]]], [[[6, 8], [2, 8]], [[2, 1], [4, 5]]]]]).reduce.to_a).to eq([[[[7, 0], [7, 7]], [[7, 7], [7, 8]]], [[[7, 7], [8, 8]], [[7, 7], [8, 7]]]]) }
    it { expect(described_class.new([[[[[7, 0], [7, 7]], [[7, 7], [7, 8]]], [[[7, 7], [8, 8]], [[7, 7], [8, 7]]]], [7, [5, [[3, 8], [1, 4]]]]]).reduce.to_a).to eq([[[[7, 7], [7, 8]], [[9, 5], [8, 7]]], [[[6, 8], [0, 8]], [[9, 9], [9, 0]]]]) }
  end
end
