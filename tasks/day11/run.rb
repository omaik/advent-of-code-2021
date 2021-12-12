module Tasks
  module Day11
    class Run
      def call1
        @flushes_count = 0

        100.times do |_i|
          to_flush = []
          input.each.with_index do |line, row_index|
            line.each.with_index do |el, col_index|
              input[row_index][col_index] += 1
              el += 1

              to_flush << [row_index, col_index] if el > 9
            end
          end

          flush(to_flush)
        end

        @flushes_count
      end

      def call2
        @flushes_count = 0
        @steps_count = 0

        loop do
          to_flush = []
          input.each.with_index do |line, row_index|
            line.each.with_index do |el, col_index|
              input[row_index][col_index] += 1
              el += 1

              to_flush << [row_index, col_index] if el > 9
            end
          end

          @steps_count += 1

          blacklist = flush(to_flush)

          break @steps_count if blacklist.size == 100
        end
      end

      private

      def flush(to_flush)
        blacklist = []
        while position = to_flush.shift
          blacklist << position
          input[position[0]][position[1]] = 0
          @flushes_count += 1

          adjacent(*position).each do |row, col|
            next unless dig(row, col)
            next if blacklist.include?([row, col])
            next if to_flush.include?([row, col])

            input[row][col] += 1
            to_flush << [row, col] if input[row][col] > 9
          end
        end
        blacklist
      end

      def dig(row_index, col_index)
        return nil if row_index.negative? || col_index.negative?

        input.dig(row_index, col_index)
      end

      def adjacent(row_index, col_index)
        [[row_index + 1, col_index],
         [row_index, col_index + 1],
         [row_index, col_index - 1],
         [row_index - 1, col_index],
         [row_index - 1, col_index + 1],
         [row_index + 1, col_index + 1],
         [row_index - 1, col_index - 1],
         [row_index + 1, col_index - 1]]
      end

      def input
        @input ||= Input.call
      end
    end
  end
end
