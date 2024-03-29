# frozen_string_literal: true

require 'tty-prompt'

require_relative '../../displayable/computer_displayable/computer_displayable'
require_relative '../game_setup'

module MasterMind
  # Setup specific to desktop
  # tty-prompt doesn't work well on mobile
  class ComputerGameSetup < GameSetup
    attr_reader :is_phone

    include ComputerDisplayable

    def initialize
      @is_phone = false
      super
    end

    private

    def first_player_role
      puts
      super(@prompt.select("#{@players[0].player_name}, choose your role :", ['Code Maker', 'Code Breaker']))
    end

    def clarify_rules
      show_guide
      @prompt.keypress('Press any key to continue')
      clear_screen
    end

    def game_mode
      puts
      super(@prompt.select('Choose a game mode :', ['Single Player', 'Multiplayer']))
    end

    def game_rounds
      puts
      super(@prompt.select('Choose how many rounds to play :', [4, 6, 8, 10, 12], default: 3))
    end

    def human_player_role
      puts
      super(@prompt.select('Choose your role :', ['Code Maker', 'Code Breaker']))
    end
  end
end
