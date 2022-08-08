# frozen_string_literal: true

require_relative './game'
require_relative './human'

module MasterMind
  class MultiplayerGame < Game
    def initialize(rounds)
      super()

      @rounds = rounds

      @players = [Human.new, Human.new]
    end

    def play
      @players[0].make_secret_code(multiplayer: true)
      @players[1].break_secret_code(@players[0], @rounds, board)
      super
    end
  end
end
