module Tasks
  module Day17
    class Input
      INPUT_FILE_PATH = "#{__dir__}/input.txt".freeze
      SAMPLE_INPUT_FILE_PATH = "#{__dir__}/input.sample.txt".freeze

      class << self
        def call
          x_range = eval(raw_input.match(/x=(.+),/)[1])
          y_range = eval(raw_input.match(/y=(.+)/)[1])

          [x_range, y_range]
        end

        def raw_input
          Inputs::Base.new(ENV['SAMPLE'] ? SAMPLE_INPUT_FILE_PATH : INPUT_FILE_PATH).call
        end
      end
    end
  end
end
