module Tasks
  module Day16
    class Package
      attr_reader :version, :operator

      class << self
        def build(input)
          version = input.shift(3).join.to_i(2)
          operator = input.shift(3).join.to_i(2)

          klass = case operator
                  when 4
                    Literal
                  else
                    Operator
                  end

          klass.new(version, operator).fetch(input)
        end
      end

      def initialize(version, operator)
        @version = version
        @operator = operator
      end
    end

    class Operator < Package
      attr_reader :length, :children

      def initialize(*args)
        super

        @children = []
      end

      def fetch(input)
        length_type_id = input.shift

        case length_type_id
        when '0'
          fetch_by_known_size(input)
        when '1'
          fetch_by_packets_count(input)
        end

        self
      end

      def fetch_by_known_size(input)
        @length = input.shift(15).join('').to_i(2)

        sub_packets_input = input.shift(@length)

        @children << Package.build(sub_packets_input) while sub_packets_input.any?
      end

      def fetch_by_packets_count(input)
        @length = input.shift(11).join('').to_i(2)

        @children << Package.build(input) while @children.size < @length
      end

      def version_sum
        @version + children.map(&:version_sum).sum
      end

      def value
        case @operator
        when 0
          @children.map(&:value).sum
        when 1
          @children.map(&:value).inject(:*)
        when 2
          @children.map(&:value).min
        when 3
          @children.map(&:value).max
        when 5
          values = @children.map(&:value)
          values[0] > values[1] ? 1 : 0
        when 6
          values = @children.map(&:value)
          values[0] < values[1] ? 1 : 0
        when 7
          values = @children.map(&:value)
          values[0] == values[1] ? 1 : 0
        end
      end
    end

    class Literal < Package
      attr_reader :value

      def fetch(input)
        acc = []
        loop do
          chunk = input.shift(5)

          acc.concat(chunk[1..])

          break if chunk[0] == '0'
        end

        @value = acc.join('').to_i(2)

        self
      end

      def version_sum
        @version
      end
    end
  end
end
