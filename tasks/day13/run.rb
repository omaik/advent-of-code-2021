module Tasks
  module Day13
    class Run
      def call1
        dots = input[:dots]

        input[:fold_rules][0..0].each do |axis, count|
          fold_y(dots, count.to_i) if axis == 'y'
          fold_x(dots, count.to_i) if axis == 'x'
        end

        dots.uniq.count
      end

      def call2
        dots = input[:dots]

        input[:fold_rules].each do |axis, count|
          fold_y(dots, count.to_i) if axis == 'y'
          fold_x(dots, count.to_i) if axis == 'x'
        end

        collector = Array.new(6) { Array.new(39) { '.' } }
        dots.uniq.sort.each do |x, y|
          collector[y][x] = '#'
        end

        "\n" + collector.map { |x| x.join }.join("\n")
      end

      private

      def fold_y(dots, count)
        dots.each do |dot|
          dot[1] = count - (dot[1] - count) if dot[1] > count
        end
      end

      def fold_x(dots, count)
        dots.each do |dot|
          dot[0] = count - (dot[0] - count) if dot[0] > count
        end
      end

      def input
        @input ||= Input.call
      end
    end
  end
end
