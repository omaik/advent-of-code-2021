module Tasks
  module Day4
    class Run
      def call1
        boards = input[:boards]
        input[:turns].each do |turn|
          boards.each do |board|
            board.each do |row|
              row.delete(turn)
            end
            return turn * board.flatten.sum / 2 if board.any?(&:empty?)
          end
        end
      end

      def call2
        boards = input[:boards]
        input[:turns].each do |turn|
          boards.each do |board|
            board.each do |row|
              row.delete(turn)
            end
          end
          boards_to_remove = boards.select { |board| board.any?(&:empty?) }
          boards.delete_if { |x| boards_to_remove.include?(x) }
          return turn * (boards_to_remove.last.flatten.sum / 2) if boards.empty?
        end
      end

      private

      def input
        Input.call
      end
    end
  end
end
