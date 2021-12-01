module Tasks
  module Day1
    class Run
      INPUT_FILE_PATH = "#{__dir__}/input.txt".freeze

      def call1
        numbers.each_cons(2).count { |x, y| y > x }
      end

      def call2
        numbers.each_cons(3).map(&:sum).each_cons(2).count { |x, y| y > x }
      end

      private

      def numbers
        Inputs::NumberStream.new(INPUT_FILE_PATH).call
      end
    end
  end
end
