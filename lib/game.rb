# frozen_string_literal: true

require_relative '../lib/tic_tac_toe/state'

class Game
  def start
    printf("\n# Tic-Tac-Toe #\n\n".blue)
    TicTacToe::State.new.start
  rescue SystemExit, Interrupt
    printf("\n\nBye!\n")
    exit
  end
end
