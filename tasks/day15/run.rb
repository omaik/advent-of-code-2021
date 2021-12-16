require 'set'
module Tasks
  module Day15
    class Run
      def call1
        starting = [0, 0]
        @known_shortest = {}
        @traverse_queue = [[starting, 0]]

        while !@final && next_one = @traverse_queue.shift
          traverse(*next_one)
        end
        @final
      end

      def call2
        multiply_map
        call1
      end

      private

      def multiply_map
        @full_map = []

        5.times do |i|
          input.each do |line|
            @full_map << line.map { |x| y = x + i; y > 9 ? y - 9 : y }
          end
        end

        @full_map.map! do |line|
          new_line = []
          5.times do |i|
            new_line.concat(line.map { |x| y = x + i; y > 9 ? y - 9 : y })
          end
          new_line
        end

        @input = @full_map
      end

      def traverse(starting, sum)
        adjacent(*starting).select { |x| dig(*x) }.sort_by { |x| dig(*x) }.each do |point|
          distance = sum + dig(*point)
          next if @known_shortest.fetch(point, Float::INFINITY) <= distance

          @known_shortest[point] = distance

          if end?(point)
            @final = distance
            return
          end

          index_to_insert = @traverse_queue.index { |x| x[1] > distance } || -1
          @traverse_queue.insert(index_to_insert, [point, distance])
        end
      end

      def dig(row_index, col_index)
        return nil if row_index.negative? || col_index.negative?

        input.dig(row_index, col_index)
      end

      def end?(point)
        (point[0] == input.size - 1) &&
          (point[1] == input.first.size - 1)
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
