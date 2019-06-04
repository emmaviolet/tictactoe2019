class Presenter

    class << self
        def request_next_move(board)
            puts "Player #{board.current_player}, pick a play:"
            display_board(board)
            puts "Play position:"
        end

        def congratulate_winner(board)
            puts "Congratulations, Player #{board.winner}, you have won!"
            puts "*" * 35
            display_board(board)
            puts "*" * 35
        end

        private

        def display_board(board)
            board_map = map_plays(board.plays)

            formatted_board = board_map.each_slice(3).map { |cells| formatted_row(cells) }
            
            formatted_board.insert(-2, "-" * 35)
            formatted_board.insert(1, "-" * 35)

            formatted_board.map { |line| puts line }
        end

        def map_plays(plays)
            (1..9).map do |number|
                play = plays.select { |play| play.position == number }.first
                play ? text_for_player(play.player) : number.to_s
            end
        end

        def text_for_player(player)
            player == 1 ? "O" : "X"
        end

        def formatted_row(cells)
            empty_line = "#{' '  * 11}|#{' '  * 11}|#{' '  * 11}"
            padding = ' '  * 5

            detail_line = cells.map { |content| padding + content + padding }.join('|')

            [ empty_line, detail_line, empty_line ]
        end
    end
end