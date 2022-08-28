# frozen_string_literal: true

module TicTacToe
  class Player
    attr_reader :marker

    def initialize(marker)
      @marker = marker
    end

    def move(board, spot)
      board.mark_spot(spot, @marker)
    end
  end

  class Computer < Player; end

  class Human < Player; end
end
