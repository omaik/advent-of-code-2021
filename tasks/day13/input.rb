module Tasks
  module Day13
    class Input
      INPUT_FILE_PATH = "#{__dir__}/input.txt".freeze
      SAMPLE_INPUT_FILE_PATH = "#{__dir__}/input.sample.txt".freeze

      class << self
        def call
          dots, fold_rules = raw_input.split("\n\n")

          dots = dots.split("\n").map { |x| x.split(',').map(&:to_i) }
          fold_rules = fold_rules.split("\n").map { |x| x.match(/(\w)=(\d+)/)[1..2] }

          {dots: dots, fold_rules: fold_rules}
        end

        def raw_input
          Inputs::Base.new(ENV['SAMPLE'] ? SAMPLE_INPUT_FILE_PATH : INPUT_FILE_PATH).call
        end
      end
    end
  end
end
