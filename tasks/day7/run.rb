module Tasks
  module Day7
    class Run
      def call1
        (0..input.max).map do |pos|
          input.map { |x| (x - pos).abs }.sum
        end.min
      end

      def call2
        (0..input.max).map do |pos|
          input.map do |x|
            dev = (x - pos).abs

            dev * (dev + 1) / 2
          end.sum
        end.min
      end

      private

      def input
        Input.call
      end
    end
  end
end
