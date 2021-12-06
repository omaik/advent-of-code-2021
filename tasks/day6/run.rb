module Tasks
  module Day6
    class Run
      def call1
        play(80)
      end

      def call2
        play(256)
      end

      def play(days)
        counts = input.each.with_object(Hash.new(0)) { |x, accum| accum[x] += 1 }

        days.times do
          zeros = counts.delete(0)
          counts = shift(counts)

          if zeros
            counts[6] += zeros
            counts[8] += zeros
          end
        end

        counts.values.sum
      end

      def shift(hash)
        8.downto(1).with_object(Hash.new(0)) do |i, new_hash|
          new_hash[i - 1] = hash[i]
        end
      end

      private

      def input
        Input.call
      end
    end
  end
end
