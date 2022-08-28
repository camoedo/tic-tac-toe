# frozen_string_literal: true

require_relative '../lib/tic_tac_toe/board'
require_relative '../lib/tic_tac_toe/player'

module TicTacToe
  describe Player do
    let(:board) { Board.new (%w[O O 3 4 O 6 X X O]) }
    let(:player) { Player.new('X') }

    it 'should add the player\'s mark on the board' do
      player.move(board, '3')
      expect(board.spots[2]).to eq 'X'
    end

    it 'should fail if the position is already taken' do
      expect { player.move(board, '1') }.to raise_error ArgumentError
    end
  end
end
