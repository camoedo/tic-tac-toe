# frozen_string_literal: true

require_relative '../colorize'

module TicTacToe
  class Board
    attr_accessor :spots

    def initialize(spots = nil)
      @spots = spots || %w[1 2 3 4 5 6 7 8 9]
    end

    def print
      puts ''
      @spots.each.with_index do |spot, index|
        index ||= (index + 1)
        index % 3 == 1 ? printf("| #{colorize(spot)} |") : printf(" #{colorize(spot)} ")
        printf("\n-----------\n") if [2, 5].include? index
      end
      printf("\n\n")
    end

    def available_spots
      @spots.select { |s| s != 'X' && s != 'O' }
    end

    def completed?
      available_spots.empty?
    end

    def valid_spot?(spot)
      !completed? && available_spots.include?(spot)
    end

    def mark_spot(spot, marker)
      raise ArgumentError, "Spot #{spot} already taken" unless valid_spot?(spot)

      @spots[spot.to_i - 1] = marker
    end

    def eval?(combination)
      [@spots[combination[0]], @spots[combination[1]], @spots[combination[2]]].uniq.length == 1
    end

    protected

    def colorize(value)
      return value.green if value == 'X'
      return value.blue if value == 'O'

      value
    end
  end
end
