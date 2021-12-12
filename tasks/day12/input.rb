module Tasks
  module Day12
    class Input
      INPUT_FILE_PATH = "#{__dir__}/input.txt".freeze
      SAMPLE_INPUT_FILE_PATH = "#{__dir__}/input.sample.txt".freeze

      class << self
        def call
          accum = Hash.new { |h, k| h[k] = [] }
          raw_input.split("\n").map { |x| x.split('-') }.each.with_object(accum) do |(x1, x2), h|
            h[x1] << x2
            h[x2] << x1
          end
        end

        def raw_input
          Inputs::Base.new(ENV['SAMPLE'] ? SAMPLE_INPUT_FILE_PATH : INPUT_FILE_PATH).call
        end
      end
    end
  end
end
