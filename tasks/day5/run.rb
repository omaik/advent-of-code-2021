module Tasks
  module Day5
    class Run
      def call1
        locations = Hash.new { |h, k| h[k] = Hash.new(0) }
        input.each do |line|
          next unless line['line']

          range(*line['vertical']).each do |v|
            range(*line['horizontal']).each do |h|
              locations[v][h] += 1
            end
          end
        end
        locations.values.map(&:values).flatten.count { |x| x >= 2 }
      end

      def call2
        locations = Hash.new { |h, k| h[k] = Hash.new(0) }
        input.each do |line|
          if line['line']
            range(*line['vertical']).each do |v|
              range(*line['horizontal']).each do |h|
                locations[v][h] += 1
              end
            end
          else
            range(*line['vertical']).each.with_index do |v, i|
              h = range(*line['horizontal']).to_a[i]
              locations[v][h] += 1
            end
          end
        end
        locations.values.map(&:values).flatten.count { |x| x >= 2 }
      end

      def range(x1, x2)
        if x1 > x2
          x1.downto(x2)
        else
          x1.upto(x2)
        end
      end

      private

      def input
        Input.call
      end
    end
  end
end
