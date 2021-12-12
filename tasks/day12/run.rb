module Tasks
  module Day12
    class Run
      def call1
        @pathes = []
        input['start'].each do |step|
          path = ['start']
          @pathes << path
          traverse_one(step, path)
        end

        @pathes.select { |x| x.last == 'end' }.count
      end

      def call2
        @pathes = []
        input['start'].each do |step|
          path = ['start']
          @pathes << path
          traverse_one_with_small_visit(step, path)
        end

        @pathes.select { |x| x.last == 'end' }.count
      end

      private

      def traverse_one(step, path)
        return if step[0].downcase == step[0] && path.include?(step)

        path << step

        return if %w[start end].include?(step)

        input[step].each do |next_step|
          new_path = path.dup
          @pathes << new_path
          traverse_one(next_step, new_path)
        end
      end

      def traverse_one_with_small_visit(step, path)
        return if step[0].downcase == step[0] && path.include?(step) && stop?(path, step)

        path << step

        return if %w[start end].include?(step)

        input[step].each do |next_step|
          new_path = path.dup
          @pathes << new_path
          traverse_one_with_small_visit(next_step, new_path)
        end
      end

      def stop?(path, step)
        step == 'start' || step == 'end' ||
          path.count(step) == 2 ||
          path.select { |x| x[0].downcase == x[0] }.group_by { |x| x }.values.any? { |x| x.size == 2 }
      end

      def input
        @input ||= Input.call
      end
    end
  end
end
