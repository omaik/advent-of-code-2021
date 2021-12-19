module Tasks
  module Day19
    class Run
      def call1
        # locations.map(&:points_from_start).flatten(1).uniq.size
      end


      def call2
        locations.combination(2).map { |x1, x2| points_difference([x1.scanner_location, x2.scanner_location]).map(&:abs).sum }.max
      end

      private

      def locations
        starting = Scanner.new(input.shift)
        starting.scanner_location = [0, 0, 0]
        known_locations = [starting]

        while input.any?

          p known_locations.size

          inp = input.shift

          res = known_locations.map do |location|
            resik = Direction.generate_rotations(inp).map do |points|
              sc = Scanner.new(points)

              map = location.points.map do |x|
                detected = sc.points.detect { |y| (x.distances & y.distances).size >= 11 }
                if detected
                  break [{x => detected}]
                else
                  nil
                end
              end.compact.first

              break [{sc: sc, map: map, points: points, neighb: location}] if map

              nil
            end

            break resik if resik.any?
          end.compact.first

          if res
            found = res[:sc]

            diff_from_neighb = points_difference(res[:map].first.reverse)

            found.scanner_location = points_sum(diff_from_neighb, res[:neighb].scanner_location)

            known_locations << found
          else
            input << inp
          end
        end

        known_locations
      end

      def input
        @input ||= Input.call
      end

      def points_difference(points)
        points.map(&:to_a).inject(:zip).map { |x| x[1] - x[0] }
      end

      def points_sum(x1, x2)
        x1.zip(x2).map(&:sum)
      end
    end

    class Scanner
      attr_reader :points

      attr_accessor :scanner_location

      def initialize(points)
        @points = points.map { |x| Point.new(*x) }
        @points.each { |x| x.calculate_distance(@points) }
      end

      def inspect
        [@points, @scanner_location]
      end

      def points_from_start
        points.map { |x| points_sum(x.to_a, @scanner_location) }
      end

      def points_sum(x1, x2)
        x1.zip(x2).map(&:sum)
      end
    end

    class Point
      attr_reader :x, :y, :z, :distances

      def initialize(x, y, z)
        @x = x
        @y = y
        @z = z
      end

      def calculate_distance(points)
        @distances = points.map { |x| distance(x) }.tap { |x| x.delete([0, 0, 0])}
      end

      def distance(other_point)
        [x - other_point.x, y - other_point.y, z - other_point.z]
      end

      def inspect
        to_a
      end

      def to_a
        [x, y, z]
      end
    end

    class Direction
      def initialize
      end

      def self.generate_rotations(points)
        rotations.map do |rotation|
          points.map do |point|
            rotation.map do |el|
              value = point[el[0]]
              el[1] == 'negative' ? -value : value
            end
          end
        end
      end

      def self.rotations
        [
          # x rotation
          [[0, 'positive'], [1, 'positive'], [2, 'positive']],
          [[0, 'positive'], [2, 'negative'], [1, 'positive']],
          [[0, 'positive'], [1, 'negative'], [2, 'negative']],
          [[0, 'positive'], [2, 'positive'], [1, 'negative']],
          # -x rotation,
          [[0, 'negative'], [1, 'negative'], [2, 'positive']],
          [[0, 'negative'], [2, 'negative'], [1, 'negative']],
          [[0, 'negative'], [1, 'positive'], [2, 'negative']],
          [[0, 'negative'], [2, 'positive'], [1, 'positive']],
          # y rotation
          [[1, 'positive'], [0, 'positive'], [2, 'negative']],
          [[1, 'positive'], [2, 'positive'], [0, 'positive']],
          [[1, 'positive'], [0, 'negative'], [2, 'positive']],
          [[1, 'positive'], [2, 'negative'], [0, 'negative']],
          # -y rotation
          [[1, 'negative'], [2, 'negative'], [0, 'positive']],
          [[1, 'negative'], [0, 'negative'], [2, 'negative']],
          [[1, 'negative'], [2, 'positive'], [0, 'negative']],
          [[1, 'negative'], [0, 'positive'], [2, 'positive']],
          # z rotation
          [[2, 'positive'], [1, 'negative'], [0, 'positive']],
          [[2, 'positive'], [0, 'positive'], [1, 'positive']],
          [[2, 'positive'], [1, 'positive'], [0, 'negative']],
          [[2, 'positive'], [0, 'negative'], [1, 'negative']],
          # -z rotation
          [[2, 'negative'], [1, 'positive'], [0, 'positive']],
          [[2, 'negative'], [0, 'positive'], [1, 'negative']],
          [[2, 'negative'], [1, 'negative'], [0, 'negative']],
          [[2, 'negative'], [0, 'negative'], [1, 'positive']]
        ]
      end
    end
  end
end
