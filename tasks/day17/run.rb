module Tasks
  module Day17
    class Run
      def call1
        detect_max_y
      end

      def call2
        trajectories = Set.new
        (input[0].last).downto(detect_possible_x.min).each do |x|
          (input[1].to_a.size * 5).downto(input[1].first).each do |y|
            trajectories << [x, y] if build_line(x, y).any?
          end
        end

        trajectories.size
      end

      private

      def detect_possible_x
        input[0].map do |el|
          d = Math.sqrt(1 + el * 8)

          x = (1 + d) / 2

          x == x.to_i ? x.to_i - 1 : nil
        end.compact
      end

      def detect_max_y
        (input[1].to_a.size * 5).downto(0).map do |y|
          build_y_trajectory(y).max
        end.compact.max
      end

      def build_y_trajectory(y)
        location_y = 0
        dots = []
        loop do
          location_y += y
          dots << location_y

          return dots if input[1].include?(location_y)

          return [] if location_y < input[1].first

          y -= 1
        end
      end

      def build_line(x, y)
        location_x = 0
        location_y = 0
        dots = []
        loop do
          location_x += x
          location_y += y
          dots << [location_x, location_y]

          return dots if input[0].include?(location_x) && input[1].include?(location_y)

          return [] if location_x > input[0].last || location_y < input[1].first

          x -= 1 if x > 0
          y -= 1
        end
      end

      def input
        @input ||= Input.call
      end
    end
  end
end
