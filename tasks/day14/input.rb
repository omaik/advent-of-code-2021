module Tasks
  module Day14
    class Input
      INPUT_FILE_PATH = "#{__dir__}/input.txt".freeze
      SAMPLE_INPUT_FILE_PATH = "#{__dir__}/input.sample.txt".freeze

      class << self
        def call
          polymer, rules = raw_input.split("\n\n")

          polymer = polymer.split('')
          rules = rules.split("\n").map { |x| x.split(' -> ') }.to_h

          OpenStruct.new(polymer: polymer, rules: rules)
        end

        def raw_input
          Inputs::Base.new(ENV['SAMPLE'] ? SAMPLE_INPUT_FILE_PATH : INPUT_FILE_PATH).call
        end
      end
    end
  end
end
