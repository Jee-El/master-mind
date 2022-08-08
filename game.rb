# frozen_string_literal: true

require_relative './board'

module MasterMind
  # A game of master mind
  class Game
    attr_reader :board

    def initialize
      @board = Board.new
    end

    def play
      end_game
    end

    def end_game
      puts 'game over'
    end
  end
end
