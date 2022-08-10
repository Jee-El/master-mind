# frozen_string_literal: true

require 'tty-prompt'

require_relative './board'
require_relative './display'

module MasterMind
  # A game of master mind
  class Game
    include Display

    def play_again?
      TTY::Prompt.new.yes?('Play again?')
    end

    private

    attr_reader :board, :player_one, :player_two

    def initialize(player_one, player_two)
      @board = Board.new
      # player_one is always of Human class
      @player_one = player_one
      @player_two = player_two
    end

    def game_over(winner)
      unless winner[1]
        puts
        puts 'The secret code was :'
        board.draw(winner.last, 0, 0, has_to_show_secret_code: true)
      end
      announce_winner(*winner[0, 2])
    end
  end
end
