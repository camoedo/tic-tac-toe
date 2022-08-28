# frozen_string_literal: true

module TicTacToe
  # Compute minmax strategy
  class Strategy
    def self.minmax(state, depth)
      return [score(state, depth), nil] if state.game_over? || depth >= 5

      scores = []
      state.board.available_spots.each do |spot|
        scores << [minmax(dup_state(state, spot), depth + 1)[0], spot]
      end
      state.current_player.is_a?(Computer) ? scores.max : scores.min
    end

    def self.score(state, depth)
      return 0 if state.winner.nil?

      state.winner.is_a?(Computer) ? +10 - depth : -10 + depth
    end

    def self.dup_state(state, current_spot)
      board = Board.new(state.board.spots.dup)
      board.mark_spot(current_spot, state.current_player.marker)
      state.class.new(state.players.rotate, board)
    end
  end
end
