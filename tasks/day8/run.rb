module Tasks
  module Day8
    class Run
      def call1
        input.values.map { |y| y.count { |x| [2, 3, 4, 7].include?(x.size) } }.sum
      end

      def call2
        input.map do |inp, out|
          out = out.map { |x| x.split('').sort.join }
          inp = inp.map { |x| x.split('').sort.join }

          store = { 1 => 2, 7 => 3, 4 => 4, 8 => 7 }.transform_values do |size|
            inp.detect { |x| x.size == size }
          end

          DETECTION_RULES.each do |n, checker|
            store[n] = inp.detect { |x| checker.call(x, store) }
          end

          out.map { |x| store.invert[x] }.join.to_i
        end.sum
      end

      private

      DETECTION_RULES = {
        9 => lambda do |input, store|
          input.size == 6 && (input.chars - (store[7].chars | store[4].chars)).size == 1
        end,
        5 => lambda do |input, store|
          input.size == 5 && (input.chars - store[4].chars).size == 2 && (store[1].chars - input.chars).size == 1
        end,
        6 => lambda do |input, store|
          input.size == 6 && (input.chars - store[5].chars).size == 1 && (store[1].chars - input.chars).size == 1
        end,
        2 => lambda do |input, store|
          input.size == 5 && (input.chars - store[5].chars).size == 2
        end,
        3 => lambda do |input, store|
          input.size == 5 && (store[1].chars - input.chars).empty?
        end,
        0 => lambda do |input, store|
          input.size == 6 && (input.chars - store[6].chars).size == 1 && (input.chars - store[5].chars).size == 2
        end
      }.freeze

      def input
        Input.call
      end
    end
  end
end
