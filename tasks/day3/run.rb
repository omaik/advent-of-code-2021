module Tasks
  module Day3
    class Run
      def call1
        arr = []
        arr2 = []
        input.first.length.times do |i|
          bits = input.map { |x| x[i] }
          arr << (bits.count('1') > bits.count('0') ? '1' : '0')
          arr2 << (bits.count('1') > bits.count('0') ? '0' : '1')
        end

        gamma = arr.join.to_i(2)
        epsilon = arr2.join.to_i(2)
        gamma * epsilon
      end

      def call2
        oxigen = input.first.length.times.inject(input) do |input, i|
          bits = input.map { |x| x[i] }
          common_bit = bits.count('1') >= bits.count('0') ? '1' : '0'

          input = input.select { |x| x[i] == common_bit }

          break input[0] if input.one?

          input
        end

        co2 = input.first.length.times.inject(input) do |input, i|
          bits = input.map { |x| x[i] }
          common_bit = bits.count('1') >= bits.count('0') ? '0' : '1'
          input = input.select { |x| x[i] == common_bit }

          break input[0] if input.one?

          input
        end

        oxigen.to_i(2) * co2.to_i(2)
      end

      private

      def input
        Input.call
      end
    end
  end
end
