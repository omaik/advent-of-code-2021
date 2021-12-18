class Integer
  def to_a
    self
  end
end



module Tasks
  module Day18
    class God
      attr_reader :registry, :left, :right, :nesting

      def initialize(array)
        @nesting = 0
        @left, @right = array
        @registry = []

        add_to_registry(self)

        @left = Pair.new(@left, 1, self) if @left.is_a?(Array)
        @right = Pair.new(@right, 1, self) if @right.is_a?(Array)
      end

      def add_to_registry(pair)
        @registry << pair
      end

      def propagating_to_left(child, number)
        if child == @left
          # nothing
        else
          @left.is_a?(Pair) ? @left.pushing_from_right(number) : @left += number
        end
      end

      def propagating_to_right(child, number)
        if child == @left
          @right.is_a?(Pair) ? @right.pushing_from_left(number) : @right += number
        else
          # nothing
        end
      end

      def reduce
        loop do
          if exp = explosive
            p "EXPLODING"
            p to_a
            p exp
            exp.explode
            p to_a
            registry.delete(exp)
          elsif sp = splittable
            p "SPLITTING"
            p to_a
            p sp
            new_pair = sp.split
            p new_pair
            p to_a
            registry.insert(registry.index(sp) + (sp.left == new_pair ? 1 : 2), new_pair)
            p registry.to_a
          else
            break
          end
        end

        self
      end

      def explosive
        @registry.detect { |x| x.nesting == 4 }
      end

      def splittable
        @registry.detect { |x| (x.left.is_a?(Integer) && x.left >= 10) || (x.right.is_a?(Integer) && x.right >= 10 )}
      end

      def to_a
        [@left.to_a, @right.to_a]
      end
    end

    class Pair
      attr_accessor :nesting, :parent, :left, :right, :index

      def initialize(array, nesting, parent)
        @left, @right = array
        @nesting = nesting
        @parent = parent

        parent.add_to_registry(self)
        @left = Pair.new(@left, nesting + 1, self) if @left.is_a?(Array)
        @right = Pair.new(@right, nesting + 1, self) if @right.is_a?(Array)
      end

      def add_to_registry(el)
        parent.add_to_registry(el)
      end

      def explode
        parent.exploding(self)
        self
      end

      def to_a
        [@left.to_a, @right.to_a]
      end

      def propagating_to_left(child, number)
        binding.pry if number == 1
        if child == @left
          parent.propagating_to_left(self, number)
        else
          @left.is_a?(Pair) ? @left.pushing_from_right(number) : @left += number
        end
      end

      def propagating_to_right(child, number)
        binding.pry if number == 1
        if child == @left
          @right.is_a?(Pair) ? @right.pushing_from_left(number) : @right += number
        else
          @parent.propagating_to_right(self, number)
        end
      end

      def pushing_from_right(number)
        if @right.is_a?(Pair)
          @right.pushing_from_right(number)
        else
          @right += number
        end
      end

      def pushing_from_left(number)
        if @left.is_a?(Pair)
          @left.pushing_from_left(number)
        else
          @left += number
        end
      end

      def exploding(node)
        if @left == node
          @left = 0
          parent.propagating_to_left(self, node.left)
          @right.is_a?(Pair) ? @right.pushing_from_left(node.right) : @right += node.right
        else
          @right = 0
          parent.propagating_to_right(self, node.right)
          @left.is_a?(Pair) ? @left.pushing_from_right(node.right) : @left += node.left
        end
      end

      def inspect
        [@left, @right, @nesting]
      end

      def split
        if @left.is_a?(Integer) && @left >= 10
          @left = Pair.new([(@left / 2.0).floor, (@left / 2.0).ceil], nesting + 1, self)
        else
          @right = Pair.new([(@right / 2.0).floor, (@right / 2.0).ceil], nesting + 1, self)
        end
      end
    end
  end
end
