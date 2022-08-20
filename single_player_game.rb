# frozen_string_literal: true

require_relative './game'
require_relative './human'
require_relative './computer'

module MasterMind
  # human vs computer
  class SinglePlayerGame < Game
    def initialize(is_phone, player_one, player_two, rounds, role)
      # player_one is always of Human class
      super(is_phone, player_one, player_two)

      @rounds = rounds
      @role = role
    end

    def play
      case @role
      when 'code maker'
        player_one.make_secret_code(false)
        winner = player_two.break_secret_code(player_one, @rounds, board)
      when 'code breaker'
        player_two.make_secret_code
        winner = player_one.break_secret_code(player_two, @rounds, board)
      end
      game_over(winner)
    end
  end
end
