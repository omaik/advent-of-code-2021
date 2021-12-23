module Tasks
  module Day21
    class Input
      INPUT_FILE_PATH = "#{__dir__}/input.txt".freeze
      SAMPLE_INPUT_FILE_PATH = "#{__dir__}/input.sample.txt".freeze

      class << self
        def call
          raw_input.split("\n").map.with_index { |x, i| Player.new(/position: (\d+)/.match(x)[1].to_i, i+1) }
        end

        def raw_input
          Inputs::Base.new(ENV['SAMPLE'] ? SAMPLE_INPUT_FILE_PATH : INPUT_FILE_PATH).call
        end
      end
    end

    class Player
      attr_accessor :position, :score
      attr_reader :index

      def initialize(position, index)
        @index = index
        @position = position
        @score = 0
      end
    end
  end
end
