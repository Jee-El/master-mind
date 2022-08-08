# frozen_string_literal: true

require_relative './game'
require_relative './human'
require_relative './computer'

module MasterMind
  class SinglePlayerGame < Game
    def initialize(rounds, role)
      super()

      @rounds = rounds
      @role = role

      @human_player = Human.new
      @computer_player = Computer.new
    end

    def play
      case @role
      when 'code maker'
        @human_player.make_secret_code
        @computer_player.break_secret_code(@human_player, @rounds, board)
      when 'code breaker'
        @computer_player.make_secret_code
        @human_player.break_secret_code(@computer_player, @rounds, board)
      end
      super
    end
  end
end
