module Tasks
  module Day2
    class Input
      INPUT_FILE_PATH = "#{__dir__}/input.txt".freeze

      class << self
        def call
          raw_input.split("\n").map do |x|
            x.split(' ').tap { |y| y[-1] = y[-1].to_i }
          end
        end

        def raw_input
          Inputs::Base.new(INPUT_FILE_PATH).call
        end
      end
    end
  end
end
