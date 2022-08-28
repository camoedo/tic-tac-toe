# frozen_string_literal: true

require_relative '../lib/tic_tac_toe/board'
require_relative '../lib/tic_tac_toe/player'
require_relative '../lib/tic_tac_toe/state'

module TicTacToe
  describe State do
    let(:state) { described_class.new([Computer.new('X'), Computer.new('O')]) }

    describe '#play_the_game' do
      it 'should end the game with a winner or a draw' do
        state.play_turn while state.winner.nil?
        expect(state.game_over?)
        expect([state.players[0], state.players[1], nil]).to include state.winner
      end
    end

    describe '#winner' do
      it "should know there's currently no winner" do
        state.board.spots = %w[1 O O X 5 X X 8 9]
        expect(state.winner).to be nil
      end

      it 'should know if X has won' do
        state.board.spots = %w[1 O O X X X X 8 9]
        expect(state.winner) == Computer.new('X')
      end

      it 'should know if O has won' do
        state.board.spots = %w[O O O 4 O 6 X X O]
        expect(state.winner) == Computer.new('O')
      end
    end

    describe '#draw?' do
      it 'should know if the board is filled up, with a winner' do
        state.board.spots = %w[X O O X O X X O O]
        expect(state.tie?).to be false
      end

      it 'should know if the board is filled up, without a winner' do
        state.board.spots = %w[X O O O O X X X O]
        expect(state.tie?).to be true
      end

      it 'should know if the board is not filled up' do
        state.board.spots = %w[1 O O X O X X X O]
        expect(state.tie?).to be false
      end
    end
  end
end
