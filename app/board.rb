require_relative 'play'

class Board

    attr_reader :plays, :winner

    def initialize
        @plays = []
    end

    def make_play(position, player)
        raise "Position #{position} is not a valid position" unless (1..9).include?(position)
        raise "Position #{position} is not available" if plays.select { |play| play.position == position }.any?
        raise "It is not Player #{player}'s turn" if current_player != player

        plays << Play.new(position, player)
    end

    def current_player
        return 1 if plays.empty?
        plays.last.player == 1 ? 2 : 1
    end

    def is_won?
        return false if plays.empty?

        positions = plays.select { |play| play.player == plays.last.player }.map(&:position)
        @winner = plays.last.player if contains_winning_streak?(positions)

        winner ? true : false
    end

    private

    def contains_winning_streak?(positions)
        winning_combinations.each do |combination|
            return true if (positions & combination).size == combination.size
        end

        false
    end

    def winning_combinations
        [
            [1, 2, 3], [4, 5, 6], [7, 8, 9],
            [1, 4, 7], [2, 5, 8], [3, 6, 9],
            [1, 5, 9], [3, 5, 7]
        ]
    end
end