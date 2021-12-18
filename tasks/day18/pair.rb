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
          @left.pushing_from_right(number)
        end
      end

      def propagating_to_right(child, number)
        if child == @left
          @right.pushing_from_left(number)
        else
          # nothing
        end
      end

      def reduce
        explode
      end

      def explode
        @registry.detect { |x| x.nesting == 4 }.explode
        self
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
        if child == @left
          parent.propagating_to_left(self, number)
        else
          @left.pushing_from_right(number)
        end
      end

      def propagating_to_right(child, number)
        if child == @left
          @right.pushing_from_left(number)
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
    end
  end
end
