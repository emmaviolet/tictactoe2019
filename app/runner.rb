# frozen_string_literal: true

require_relative 'board'
require_relative 'presenter'

class Runner
    def self.play
        new.play
    end

    def initialize
        @board = Board.new
    end

    def play
        play_next_move until board.won?
        Presenter.congratulate_winner(board)
    end

    private

    attr_reader :board

    def play_position(number, player)
        board.make_play(number.to_i, player)
    rescue RuntimeError => e
        puts e.message
        play_next_move
    end

    def play_next_move
        Presenter.request_next_move(board)
        position = gets.chomp.to_i
        play_position(position, board.current_player)
    end
end
