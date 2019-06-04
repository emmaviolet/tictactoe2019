# frozen_string_literal: true

require_relative 'player'

Play = Struct.new(:position, :player)

class Board
    attr_reader :winner

    def initialize
        @plays = []
        @players = [Player.new('Player 1'), Player.new('Player 2')]
    end

    def make_play(position, player)
        validate_play(position, player)
        plays << Play.new(position, player)

        check_for_win
    end

    def grid
        (1..9).map do |number|
            play = plays.select { |p| p.position == number }.first
            play ? play.player.icon : number
        end.each_slice(3).to_a
    end

    def current_player
        return players.first if plays.empty?

        plays.last.player == players.first ? players.last : players.first
    end

    def won?
        winner ? true : false
    end

    private

    attr_reader :plays, :players

    def validate_play(position, player)
        invalid = !(1..9).include?(position)
        unavailable = plays.select { |play| play.position == position }.any?

        raise "Position #{position} is not a valid position" if invalid
        raise "Position #{position} is not available" if unavailable
        raise "It is not #{player.title}'s turn" if current_player != player
    end

    def check_for_win
        positions = plays.select do |play|
            play.player == plays.last.player
        end.map(&:position)
        @winner = plays.last.player if contains_winning_streak?(positions)
    end

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
