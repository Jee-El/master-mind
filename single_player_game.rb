# frozen_string_literal: true

require_relative './game'
require_relative './human'
require_relative './computer'

module MasterMind
  # human vs computer
  class SinglePlayerGame < Game
    def initialize(rounds, role)
      super()

      @rounds = rounds
      @role = role

      @human_player = Human.new(false)
      @computer_player = Computer.new
    end

    def play
      case @role
      when 'code maker'
        @human_player.make_secret_code(false)
        winner = @computer_player.break_secret_code(@human_player, @rounds, board)
      when 'code breaker'
        @computer_player.make_secret_code
        winner = @human_player.break_secret_code(@computer_player, @rounds, board)
      end
      game_over(winner)
    end
  end
end
