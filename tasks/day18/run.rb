module Tasks
  module Day18
    class Run
      def call1
        first = input.shift

        God.new(input.inject(first) do |first, second|
          God.new([first, second]).reduce.to_a
        end).magnitude
      end

      def call2
        input.permutation(2).map do |first, second|
          God.new([first, second]).reduce.magnitude
        end.max
      end

      private

      def input
        @input ||= Input.call
      end
    end
  end
end
