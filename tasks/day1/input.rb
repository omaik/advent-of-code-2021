module Tasks
  module Day1
    class Input
      INPUT_FILE_PATH = "#{__dir__}/input.txt".freeze

      class << self
        def call
          raw_input.split("\n").map(&:to_i)
        end

        def raw_input
          Inputs::Base.new(INPUT_FILE_PATH).call
        end
      end
    end
  end
end
