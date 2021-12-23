module Tasks
  module Day20
    class Run
      def call1
        enhance(2)
      end

      def call2
        enhance(50)
      end

      private

      def enhance(times)
        algo = input[:algo]

        image = input[:image]
        times.times do
          new_image = Input::Image.new

          ((image.map.keys.min - 1)..(image.map.keys.max + 1)).each do |y|
            x_map = image.map.values.first

            ((x_map.keys.min - 1)..(x_map.keys.max + 1)).each do |x|
              value = calculate_value(algo, image, y, x)

              new_image.add_to_map(y, x, value)
            end
          end

          new_default = algo[(image.default * 9).tr('#.', '10').to_i(2)]

          new_image.default = new_default

          image = new_image
        end

        image.shining_count
      end

      def calculate_value(algo, image, y, x)
        index = neighbours(y, x).map do |y, x|
          image.map[y][x]
        end.join('').tr('#.', '10').to_i(2)

        algo[index]
      end

      def neighbours(y, x)
        [
          [y - 1, x - 1],
          [y - 1, x],
          [y - 1, x + 1],
          [y, x - 1],
          [y, x],
          [y, x + 1],
          [y + 1, x - 1],
          [y + 1, x],
          [y + 1, x + 1]
        ]
      end

      def input
        @input ||= Input.call
      end
    end
  end
end
