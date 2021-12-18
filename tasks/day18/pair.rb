class Integer
  def to_a
    self
  end

  def nesting
    0
  end

  def magnitude
    self
  end

  def pushing_from_left(number)
    self + number
  end

  def pushing_from_right(number)
    self + number
  end

  def detect_explosive; end

  def splittable; end
end

module Tasks
  module Day18
    class God
      attr_reader :left, :right, :nesting

      def initialize(array)
        @nesting = 0
        @left, @right = array

        @left = Pair.new(@left, 1, self) if @left.is_a?(Array)
        @right = Pair.new(@right, 1, self) if @right.is_a?(Array)
      end

      def propagating_to_left(child, number)
        if child == @right
          @left.is_a?(Pair) ? @left.pushing_from_right(number) : @left += number
        end
      end

      def propagating_to_right(child, number)
        if child == @left
          @right =  @right.pushing_from_left(number)
        end
      end

      def reduce
        loop do
          if exp = explosive
            exp.explode
          elsif sp = splittable
            new_pair = sp.split
          else
            break
          end
        end

        self
      end

      def explosive
        @left.detect_explosive || @right.detect_explosive
      end

      def splittable
        if @left >= 10
          self
        else
          @left.splittable || (@right >= 10 ? self : @right.splittable)
        end
      end

      def to_a
        [@left.to_a, @right.to_a]
      end

      def magnitude
        @left.magnitude * 3 + @right.magnitude * 2
      end
    end

    class Pair
      attr_accessor :nesting, :parent, :left, :right, :index

      def initialize(array, nesting, parent)
        @left, @right = array
        @nesting = nesting
        @parent = parent

        @left = Pair.new(@left, nesting + 1, self) if @left.is_a?(Array)
        @right = Pair.new(@right, nesting + 1, self) if @right.is_a?(Array)
      end

      def >=(_other)
        false
      end

      def splittable
        if @left >= 10
          self
        else
          @left.splittable || (@right >= 10 ? self : @right.splittable)
        end
      end

      def explode
        parent.exploding(self)
        self
      end

      def to_a
        [@left.to_a, @right.to_a]
      end

      def magnitude
        @left.magnitude * 3 + @right.magnitude * 2
      end

      def propagating_to_left(child, number)
        if child == @left
          parent.propagating_to_left(self, number)
        else
          @left.is_a?(Pair) ? @left.pushing_from_right(number) : @left += number
        end
      end

      def propagating_to_right(child, number)
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

        self
      end

      def pushing_from_left(number)
        if @left.is_a?(Pair)
          @left.pushing_from_left(number)
        else
          @left += number
        end
        self
      end

      def detect_explosive
        return @left if @left.nesting == 4
        return @left.detect_explosive if @left.detect_explosive
        return @right if @right.nesting == 4

        @right.detect_explosive
      end

      def exploding(node)
        if @left == node
          @left = 0
          parent.propagating_to_left(self, node.left)
          @right = @right.pushing_from_left(node.right)
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
