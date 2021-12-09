require 'set'
module Tasks
  module Day9
    class Run
      def call1
        low_points.map(&:first).map(&:next).sum
      end

      def call2
        low_points.map do |x|
          Set.new.tap { |basin| convert_to_basin(basin, x[1], x[2]) }
        end.map(&:size).sort.last(3).inject(:*)
      end

      private

      def low_points
        input.each.with_index.with_object([]) do |(line, row_index), low_points|
          line.each.with_index do |inp, col_index|
            low_points << [inp, row_index, col_index] if no_bigger?(inp, row_index, col_index)
          end
        end
      end

      def convert_to_basin(basin, row_index, col_index)
        point = input[row_index][col_index]

        basin << [row_index, col_index]
        adjacent(row_index, col_index).select do |(x, y)|
          dig(x, y) && (dig(x, y) > point) && dig(x, y) != 9
        end.map do |(x, y)|
          convert_to_basin(basin, x, y)
        end
      end

      def no_bigger?(inp, row_index, col_index)
        adjacent_values = adjacent(row_index, col_index).map { |row, col| dig(row, col) }

        adjacent_values.compact.all? { |x| inp < x }
      end

      def dig(row_index, col_index)
        return nil if row_index.negative? || col_index.negative?

        input.dig(row_index, col_index)
      end

      def adjacent(row_index, col_index)
        [[row_index + 1, col_index],
         [row_index, col_index + 1],
         [row_index, col_index - 1],
         [row_index - 1, col_index]]
      end

      def input
        @input ||= Input.call
      end
    end
  end
end
