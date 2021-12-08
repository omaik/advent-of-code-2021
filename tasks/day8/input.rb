module Tasks
  module Day8
    class Input
      INPUT_FILE_PATH = "#{__dir__}/input.txt".freeze

      class << self
        def call
          raw_input.split("\n").map { |x| x.split(' | ').map { |x| x.split(' ') } }.to_h
        end

        def raw_input
          Inputs::Base.new(INPUT_FILE_PATH).call
        end
      end
    end
  end
end
