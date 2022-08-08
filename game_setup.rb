# frozen_string_literal: true

require_relative './messages'

module MasterMind
  # Setup game mode, human player role, rounds to play
  class GameSetup
    attr_reader :settings

    def initialize
      @settings = {}
    end

    def start
      @settings[:game_mode] = game_mode.downcase
      @settings[:rounds] = rounds
      unless @settings[:game_mode] == 'multiplayer'
        @settings[:human_player_role] = human_player_role.downcase
      end
    end

    private

    include Messages

    def game_mode
      ask_for_game_mode
    end

    def human_player_role
      ask_for_human_player_role
    end

    def rounds
      ask_for_rounds_amount
    end
  end
end
