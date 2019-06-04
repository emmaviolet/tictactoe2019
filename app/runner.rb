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
        play_next_move until board.is_won?
        Presenter.congratulate_winner(board)
    end

    private

    attr_reader :board

    def play_position(number, player)
        board.make_play(number.to_i, player)
    end

    def play_next_move
        # should we know about the current player? is it useful for future us?

        Presenter.request_next_move(board)
        position = gets.chomp.to_i
        play_position(position, board.current_player)
    end
end