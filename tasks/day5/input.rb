module Tasks
  module Day5
    class Input
      INPUT_FILE_PATH = "#{__dir__}/input.txt".freeze

      class << self
        def call
          raw_input.split("\n").map do |x|
            coord = x.match(/(\d+),(\d+) -> (\d+),(\d+)/)[1..].map(&:to_i)
            { 'horizontal' => [coord[0], coord[2]], 'vertical' => [coord[1], coord[3]],
              'line' => (coord[0] - coord[2]).zero? || (coord[1] - coord[3]).zero? }
          end
        end

        def raw_input
          Inputs::Base.new(INPUT_FILE_PATH).call
        end
      end
    end
  end
end
