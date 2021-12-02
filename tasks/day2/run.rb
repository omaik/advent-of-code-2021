module Tasks
  module Day2
    class Run
      INPUT_FILE_PATH = "#{__dir__}/input.txt".freeze

      def call1
        counts = groups.inject({}) do |accum, el|
          accum.merge(Hash[*el]) { |_k, v1, v2| v1.to_i + v2.to_i }
        end

        counts['forward'] * (counts['down'] - counts['up'])
      end

      def call2
        aim = 0
        down = 0
        forward = 0

        groups.each do |key, value|
          case key
          when 'forward'
            forward += value
            down += value * aim
          when 'down'
            aim += value
          when 'up'
            aim -= value
          end
        end

        down * forward
      end

      private

      def groups
        Input.call
      end
    end
  end
end
