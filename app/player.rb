class Player

    attr_reader :title

    def initialize(title)
        @title = title
    end

    def icon
        title == 'Player 1' ? 'O' : 'X'
    end
end