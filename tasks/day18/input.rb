module Tasks
  module Day18
    class Input
      INPUT_FILE_PATH = "#{__dir__}/input.txt".freeze
      SAMPLE_INPUT_FILE_PATH = "#{__dir__}/input.sample.txt".freeze

      class << self
        def call
          eval(raw_input)
        end

        def raw_input
          Inputs::Base.new(ENV['SAMPLE'] ? SAMPLE_INPUT_FILE_PATH : INPUT_FILE_PATH).call
        end
      end
    end
  end
end
