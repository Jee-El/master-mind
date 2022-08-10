# frozen_string_literal: true

require_relative './game'
require_relative './human'

module MasterMind
  # human vs human
  class MultiplayerGame < Game
    def initialize(player_one, player_two, rounds)
      super(player_one, player_two)
      @rounds = rounds
    end

    def play
      player_one.make_secret_code(true)
      clear_screen
      winner = player_two.break_secret_code(player_one, @rounds, board)
      game_over(winner)
    end
  end
end
