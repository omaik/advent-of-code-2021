module Tasks
  module Day4
    class Input
      INPUT_FILE_PATH = "#{__dir__}/input.txt".freeze

      class << self
        def call
          raw_input.split("\n")
        end

        def raw_input
          Inputs::Base.new(INPUT_FILE_PATH).call
        end
      end
    end
  end
end
