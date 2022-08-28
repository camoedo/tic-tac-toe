# frozen_string_literal: true

require_relative '../colorize'
require_relative '../helper'

require_relative './board'
require_relative './player'
require_relative './strategy'

module TicTacToe
  # This class handle the game state
  class State
    WINNING_COMBINATIONS = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]
    ].freeze
    PLAYERS_COMBINATIONS = [
      [Human.new('X'), Computer.new('O')],
      [Human.new('X'), Human.new('O')],
      [Computer.new('X'), Computer.new('O')]
    ].freeze
    DIFFICULTY = { easy: 4, hard: 0 }.freeze

    attr_reader :players, :board

    def initialize(players = [], board = Board.new)
      @players = players
      @board = board
      @difficulty = DIFFICULTY[:easy]
    end

    def start
      printf("Game options:\n\n")

      handle_players_options
      handle_difficulty_options if @players[0].class != players[1].class

      print_selected_options

      @board.print
      until game_over?
        play_turn
        @board.print
      end

      print_results
    end

    def tie?
      @board.completed? && winner.nil?
    end

    def winner
      WINNING_COMBINATIONS.each do |combination|
        @players.each do |player|
          return player if combination.all? { |spot| @board.spots[spot] == player.marker }
        end
      end

      nil
    end

    def game_over?
      !winner.nil? || tie?
    end

    def current_player
      @players.first
    end

    def players_are?(klass)
      @players.all? { |p| p.is_a?(klass) }
    end

    def play_turn
      spot = current_player.is_a?(Human) ? human_turn : computer_turn
      current_player&.move(@board, spot)
      @players.rotate!
    rescue ArgumentError => e
      printf("#{e.message}. Please choose another number...\n".red)
    end

    protected

    def print_selected_options
      printf("\n#{demodulize(@players[0])} vs #{demodulize(@players[1])} - Ready!".blue)
      printf("\nTip: Numbers represent board positions.\n")
    end

    def handle_players_options
      option = get_selected_option(
        'Players - Human vs Computer [1] Human vs Human [2] Computer vs Computer [3]:', [1, 2, 3]
      )

      @players = PLAYERS_COMBINATIONS[option - 1]

      if option == 1
        first_player = get_selected_option('First player - Human [1] Computer [2]:', [1, 2])
        return @players.rotate! if first_player == 2
      end

      @players.shuffle! if option == 3
    end

    def handle_first_player_options
      option = get_selected_option('First player - Human [1] Computer [2]:', [1, 2])
      option == 2 && @players.rotate!
    end

    def handle_difficulty_options
      option = get_selected_option('Difficulty - Easy [1] Hard [2]:', [1, 2])
      @difficulty = option == 1 ? DIFFICULTY[:easy] : DIFFICULTY[:hard]
    end

    def random_spot
      @board.available_spots.sample
    end

    def find_best_spot
      best_move = Strategy.minmax(self, @difficulty)
      best_move[1]
    end

    def human_turn
      printf("Your turn (you are #{current_player&.marker}). Enter [1-9]: ".green)
      spot = gets.chomp.strip
      raise ArgumentError, 'Input invalid' unless (1..9).to_a.include?(spot.to_i)

      spot
    end

    def computer_turn
      printf("Computer's turn (#{current_player&.marker} marker).\n".blue)
      players_are?(Computer) ? random_spot : find_best_spot
    end

    def human_won_over_computer?
      winner.is_a?(Human) && !players_are?(Human)
    end

    def computer_won_over_human?
      winner.is_a?(Computer) && !players_are?(Computer)
    end

    def print_results
      return printf("There's a tie!\n".yellow) if tie?
      return printf("You are the winner! Congrats!!!!\n".yellow) if human_won_over_computer?
      return printf("You loose! Computer wins...\n".red) if computer_won_over_human?

      printf("#{demodulize(winner)} with the marker #{winner&.marker} wins...\n".yellow)
    end
  end
end
