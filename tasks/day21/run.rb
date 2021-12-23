module Tasks
  module Day21
    class Run
      def call1
        players = input
        die = Die.new

        loop do
          player = players.shift

          position = (3.times.map { die.next }.sum + player.position) % 10
          position = 10 if position.zero?

          player.score += position
          player.position = position

          players << player

          break if player.score >= 1000
        end

        die.counter * players.first.score
      end

      def call2
        players = input
        @cache = {}

        into_universe(players)
      end

      private

      def into_universe(players, step = [])
        if step.any?
          player = players.shift
          position = (step.sum + player.position) % 10
          position = 10 if position.zero?

          player.score += position
          player.position = position

          players << player
          return { player.index => 1, players.first.index => 0 } if player.score >= 21
        end

        cache_key = players.map { |x| [x.index, x.score, x.position] }
        return @cache[cache_key] if @cache.include?(cache_key)

        results = [1, 2, 3].repeated_permutation(3).map do |st|
          into_universe(players.map(&:clone), st)
        end

        first = results.map { |x| x[1] }.sum
        second = results.map { |x| x[2] }.sum

        @cache[cache_key] = { 1 => first, 2 => second }

        { 1 => first, 2 => second }
      end

      def input
        @input ||= Input.call
      end
    end

    class Die
      attr_reader :counter

      def initialize
        @counter = 0
      end

      def next
        @counter += 1
        @counter
      end
    end
  end
end
