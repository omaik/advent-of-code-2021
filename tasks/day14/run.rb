module Tasks
  module Day14
    class Run
      def call1
        polymer = input.polymer

        10.times do
          new_polymer = []

          polymer.each_cons(2) do |a1, a2|
            new_polymer.push(a1, input.rules["#{a1}#{a2}"])
          end

          new_polymer << polymer.last

          polymer = new_polymer
        end

        polymer.group_by { |x| x }.values.map(&:size).minmax.reverse.inject(:-)
      end

      def call2
        counts = Hash.new(0)
        polymer = input.polymer.each_cons(2).map { |x, y| x + y }
        rules = input.rules.map { |k, v| [k, [k[0] + v, v + k[1]]] }.to_h

        polymer.each do |k|
          counts[k] += 1
        end

        40.times do
          new_counts = Hash.new(0)

          counts.each_key do |key|
            rules[key].each do |new_key|
              new_counts[new_key] += counts[key]
            end
          end

          counts = new_counts
        end

        sums = counts.group_by { |k| k[0][1] }.transform_values { |x| x.map { |y| y[1] }.sum }

        sums[input.polymer.first] += 1

        sums.values.minmax.reverse.inject(:-)
      end

      private

      def input
        @input ||= Input.call
      end
    end
  end
end
