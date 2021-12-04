module Tasks
  module Day4
    class Input
      INPUT_FILE_PATH = "#{__dir__}/input.txt".freeze

      class << self
        def call
          game = raw_input.split("\n\n")
          { turns: game.first.split(',').map(&:to_i),
            boards: game[1..].map do |x|
                      rows = x.split("\n").map { |x| x.split.map(&:to_i) }
                      rows + rows.transpose
                    end }
        end

        def raw_input
          Inputs::Base.new(INPUT_FILE_PATH).call
        end
      end
    end
  end
end
