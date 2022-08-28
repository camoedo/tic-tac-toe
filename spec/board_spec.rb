# frozen_string_literal: true

require_relative '../lib/tic_tac_toe/board'

module TicTacToe
  describe Board do
    let(:board) { described_class.new }

    describe '#valid_spot?' do
      it 'should know whether a spot is empty or not' do
        board.spots = %w[X O O X 5 X X X O]
        expect(board.valid_spot?('5')).to be true
        expect(board.valid_spot?('1')).to be false
      end
    end

    describe '#get_available_spots' do
      it 'should know all available positions' do
        board.spots = %w[O 2 3 4 O 6 X X O]
        expect(board.available_spots).to eq %w[2 3 4 6]
      end
    end
  end
end
