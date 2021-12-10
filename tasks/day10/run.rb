module Tasks
  module Day10
    class Run
      VALUES = {
        '}' => 1197,
        ')' => 3,
        ']' => 57,
        '>' => 25_137
      }.freeze

      VALUES2 = {
        '}' => 3,
        ')' => 1,
        ']' => 2,
        '>' => 4
      }.freeze

      def call1
        input.map do |line|
          invalid_char(line)
        end.compact.map { |x| VALUES[x] }.sum
      end

      def call2
        missing = input.reject do |line|
          invalid_char(line)
        end
        missing.map do |line|
          missing(line).inject(0) do |x, char|
            x * 5 + VALUES2[char]
          end
        end.sort[missing.size / 2]
      end

      private

      def missing(line)
        counters = Hash.new { |h, k| h[k] = [] }
        line.each.with_index do |char, index|
          if OPPOSITE.key?(char)
            counters[OPPOSITE[char]].pop
          else
            counters[char] << index
          end
        end

        inv_counters = {}
        counters.each do |char, indexes|
          indexes.each do |i|
            inv_counters[i] = OPPOSITE.invert[char]
          end
        end
        inv_counters.sort.reverse.map(&:last)
      end

      def input
        @input ||= Input.call
      end

      def invalid_char(line)
        counters = Hash.new { |h, k| h[k] = [] }
        line.each.with_index do |char, index|
          if OPPOSITE.key?(char)
            start = counters[OPPOSITE[char]].pop
            return char if start.nil?

            in_chunk = detect_invalid_in_chunk(line[(start + 1)...index])
            return char if in_chunk
          else
            counters[char] << index
          end
        end
        nil
      end

      def detect_invalid_in_chunk(line)
        counters = Hash.new { |h, k| h[k] = [] }
        line.each.with_index do |char, index|
          counters[char] << index
        end

        OPPOSITE.each do |k, v|
          return k if counters[v].size > counters[k].size
        end

        nil
      end

      OPPOSITE = { '}' => '{', ']' => '[', ')' => '(', '>' => '<' }.freeze
    end
  end
end
