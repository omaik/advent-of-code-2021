module Tasks
  module Day20
    class Input
      INPUT_FILE_PATH = "#{__dir__}/input.txt".freeze
      SAMPLE_INPUT_FILE_PATH = "#{__dir__}/input.sample.txt".freeze

      class << self
        def call
          algo, image = raw_input.split("\n\n")

          algo = algo.gsub("\n", '')
          { algo: algo, image: Image.from_input(image) }
        end

        def raw_input
          Inputs::Base.new(ENV['SAMPLE'] ? SAMPLE_INPUT_FILE_PATH : INPUT_FILE_PATH).call
        end
      end

      class Image
        attr_accessor :default
        attr_reader :map

        def initialize
          @default = '.'
          @map = Hash.new { |h, k| h[k] = Hash.new { @default } }
        end

        def add_to_map(y, x, el)
          @map[y][x] = el
        end

        def inspect
          @map
        end

        def print
          @map.each_value do |x|
            puts x.values.join
          end
        end

        def shining_count
          @map.values.map(&:values).flatten.count('#')
        end

        def self.from_input(input)
          image = new

          input.split("\n").each.with_index do |line, y|
            line.split('').each.with_index do |char, x|
              image.add_to_map(y, x, char)
            end
          end

          image
        end
      end
    end
  end
end
