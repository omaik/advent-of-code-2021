module Tasks
  module Day22
    class Run
      def call1
        # x = Hash.new('off')

        # y = Hash.new { |h, k| h[k] = x.clone }

        # world = Hash.new { |h, k| h[k] = y.clone }

        # input.each.with_index do  |el, _i|
        #   el.z.each do |z_index|
        #     el.y.each do |y_index|
        #       el.x.each do |x_index|
        #         world[z_index][y_index][x_index] = el.command
        #       end
        #     end
        #   end
        # end

        # world.values.map { |x| x.values.map(&:values) }.flatten.count('on')
      end

      def call2
        @agg = []
        input.each.with_index do |el, _i|
          if el.command == 'on'
            @agg << el
          else
            split(el)
          end
        end


        join


        @agg.uniq.map { |x| x.x.size * x.y.size * x.z.size }.sum

        # x = Hash.new('off')

        # y = Hash.new { |h, k| h[k] = x.clone }

        # world = Hash.new { |h, k| h[k] = y.clone }

        # @agg.each.with_index do |el, i|
        #   p i
        #   el.z.each do |z_index|
        #     el.y.each do |y_index|
        #       el.x.each do |x_index|
        #         world[z_index][y_index][x_index] = el.command
        #       end
        #     end
        #   end
        # end

        # world.values.map { |x| x.values.map(&:values) }.flatten.count('on')
      end

      def split(el)
        z_split(el)
        y_split(el)
        x_split(el)
      end

      def z_split(el)
        new_agg = []
        @agg.each do |ell|
          if ell.z.max < el.z.min || ell.z.min > el.z.max # out of range from left or right
            new_agg << ell
          elsif ell.z.min >= el.z.min && ell.z.max <= el.z.max # total overlap by z
            x = ell.clone
            x.no_z = true
            new_agg << x
          elsif el.z.min > ell.z.min && el.z.max >= ell.z.max
            z1 = (ell.z.min..(el.z.min - 1))
            z2 = (el.z.min..ell.z.max)

            x1 = ell.clone
            x1.z = z1
            x2 = ell.clone
            x2.z = z2
            x2.no_z = true

            new_agg << x1
            new_agg << x2

          elsif el.z.min <= ell.z.min && el.z.max < ell.z.max
            z1 = (ell.z.min..(el.z.max))
            z2 = ((el.z.max + 1)..ell.z.max)

            x1 = ell.clone
            x1.z = z1
            x1.no_z = true
            x2 = ell.clone
            x2.z = z2

            new_agg << x1
            new_agg << x2
          elsif ell.z.min < el.z.min && ell.z.max > el.z.max
            z1 = ell.z.min..(el.z.min - 1)
            z2 = el.z
            z3 = (el.z.max + 1)..ell.z.max

            x1 = ell.clone
            x1.z = z1
            x2 = ell.clone
            x2.z = z2
            x2.no_z = true
            x3 = ell.clone
            x3.z = z3

            new_agg << x1
            new_agg << x2
            new_agg << x3
          end
        end
        @agg = new_agg
      end

      def y_split(el)
        new_agg = []
        @agg.each do |ell|
          if !ell.no_z
            new_agg << ell
          elsif ell.y.max < el.y.min || ell.y.min > el.y.max
            x = ell.clone
            x.no_z = false
            new_agg << x
          elsif ell.y.min >= el.y.min && ell.y.max <= el.y.max
            x = ell.clone
            x.no_y = true
            new_agg << x
          elsif el.y.min > ell.y.min && el.y.max >= ell.y.max
            x1 = ell.clone
            x2 = ell.clone

            y1 = (ell.y.min..(el.y.min - 1))
            y2 = (el.y.min..ell.y.max)

            x1.no_z = false
            x1.y = y1

            x2.no_y = true
            x2.y = y2

            new_agg << x1
            new_agg << x2
          elsif el.y.min <= ell.y.min && el.y.max < ell.y.max
            y1 = (ell.y.min..(el.y.max))
            y2 = ((el.y.max + 1)..ell.y.max)

            x1 = ell.clone
            x1.y = y1
            x1.no_y = true
            x2 = ell.clone
            x2.y = y2
            x2.no_z = false

            new_agg << x1
            new_agg << x2
          elsif ell.y.min < el.y.min && ell.y.max > el.y.max
            y1 = ell.y.min..(el.y.min - 1)
            y2 = el.y
            y3 = (el.y.max + 1)..ell.y.max

            x1 = ell.clone
            x1.y = y1
            x1.no_z = false
            x2 = ell.clone
            x2.y = y2
            x2.no_y = true
            x3 = ell.clone
            x3.y = y3
            x3.no_z = false

            new_agg << x1
            new_agg << x2
            new_agg << x3
          else
            binding.pry
          end
        end

        @agg = new_agg
      end

      def x_split(el)
        new_agg = []
        @agg.each do |ell|
          if !ell.no_y
            new_agg << ell
          elsif ell.x.max < el.x.min || ell.x.min > el.x.max
            x = ell.clone
            x.no_z = false
            x.no_y = false
            new_agg << x
          elsif ell.x.min >= el.x.min && ell.x.max <= el.x.max
            # drop such
          elsif el.x.min > ell.x.min && el.x.max >= ell.x.max
            x1 = ell.clone
            # x2 = ell.clone

            y1 = (ell.x.min..(el.x.min - 1))
            # y2 = (el.x.min..ell.x.max)

            x1.no_z = false
            x1.no_y = false
            x1.x = y1

            new_agg << x1
            # x2 gets dropped
            # new_agg << x2
          elsif el.x.min <= ell.x.min && el.x.max < ell.x.max
            # y1 = (ell.x.min..(el.x.max))
            y2 = ((el.x.max + 1)..ell.x.max)

            # x1 = ell.clone
            # x1.x = y1
            x2 = ell.clone
            x2.x = y2
            x2.no_z = false
            x2.no_y = false

            # x1 gets dropped
            # new_agg << x1
            new_agg << x2
          elsif ell.x.min < el.x.min && ell.x.max > el.x.max
            y1 = ell.x.min..(el.x.min - 1)
            y3 = (el.x.max + 1)..ell.x.max

            x1 = ell.clone
            x1.x = y1
            x1.no_z = false
            x1.no_y = false
            x3 = ell.clone
            x3.x = y3
            x3.no_z = false
            x3.no_y = false

            # p [x1, x2, x3]
            new_agg << x1
            # new_agg << x2
            new_agg << x3
          else
            binding.pry
          end
        end
        @agg = new_agg
      end

      def join
        buf = []
        i = 0
        loop do
          el1 = @agg.shift

          buf << el1

          overlapping_group = @agg.select { |x| x.overlap?(el1) }

          old_agg = @agg - overlapping_group

          @agg = overlapping_group

          split(el1)

          @agg = @agg + old_agg

          if rand(1000) == 15
            p @agg.size
            p buf.size

            p "----"
          end

          break if @agg.empty?
        end

        @agg = buf
      end

      private

      def input
        @input ||= Input.call
      end

      class Kube
        attr_accessor :command

        def initialize
          @command = 'off'
        end
      end
    end
  end
end
