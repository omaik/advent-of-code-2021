module Tasks
  module Day22
    class Input
      INPUT_FILE_PATH = "#{__dir__}/input.txt".freeze
      SAMPLE_INPUT_FILE_PATH = "#{__dir__}/input.sample.txt".freeze

      class << self
        def call
          raw_input.split("\n").map do |line|
            Kubicle.create(line)
          end
        end

        def raw_input
          Inputs::Base.new(ENV['SAMPLE'] ? SAMPLE_INPUT_FILE_PATH : INPUT_FILE_PATH).call
        end
      end
    end

    class Kubicle
      def self.create(line)
        command, x_range, y_range, z_range = /(\w+)\sx=(.+),y=(.+),z=(.+)/.match(line)[1..4]

        new(command, eval(x_range), eval(y_range), eval(z_range))
      end

      attr_accessor :x, :y, :z, :command

      attr_accessor :no_z, :no_y

      def initialize(command, x, y, z)
        @x = x
        @y = y
        @z = z
        @command = command
      end
    end
  end
end
