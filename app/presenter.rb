class Presenter

    class << self
        def request_next_move(board)
            puts "#{board.current_player.title}, pick a play:"
            display_board(board)
            puts "Play position:"
        end

        def congratulate_winner(board)
            puts "Congratulations, #{board.winner.title}, you have won!"
            puts "*" * 35
            display_board(board)
            puts "*" * 35
        end

        private

        def display_board(board)
            formatted_board = board.grid.map { |cells| formatted_row(cells) }
            
            formatted_board.insert(-2, "-" * 35)
            formatted_board.insert(1, "-" * 35)

            formatted_board.map { |line| puts line }
        end

        def formatted_row(cells)
            empty_line = "#{' '  * 11}|#{' '  * 11}|#{' '  * 11}"
            padding = ' '  * 5

            detail_line = cells.map { |content| padding + content.to_s + padding }.join('|')

            [ empty_line, detail_line, empty_line ]
        end
    end
end