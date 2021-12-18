module Tasks
  module Day18
    class Run
      def call1
        first = input.shift

        input.inject(first) do |first, second|
          p "Adding", first, second
          p God.new([first, second]).reduce.to_a
        end
      end

      def call2
      end

      private

      def input
        @input ||= Input.call
      end
    end
  end
end
