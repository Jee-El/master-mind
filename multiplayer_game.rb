# frozen_string_literal: true

require_relative './game'
require_relative './human'

module MasterMind
  # human vs human
  class MultiplayerGame < Game
    def initialize(rounds)
      super()
      @rounds = rounds

      @players = [Human.new(true, 'first'), Human.new(true, 'second')]
    end

    def play
      @players[0].make_secret_code(true)
      clear_screen
      winner = @players[1].break_secret_code(@players[0], @rounds, board)
      game_over(winner)
    end

    def clear_screen
      puts "\e[1;1H\e[2J"
    end
  end
end
