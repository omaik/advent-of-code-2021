module Tasks
  module Day18
    class Run
      def call1
        God.new(input).explode.to_a
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
