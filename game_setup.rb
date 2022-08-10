# frozen_string_literal: true

require 'tty-prompt'
require 'tty-box'
require 'colorize'

require_relative './board'
require_relative './display'
require_relative './single_player_game'
require_relative './multiplayer_game'

module MasterMind
  # Setup game mode, human player role, rounds to play
  class GameSetup
    attr_reader :settings

    include Display

    def initialize
      @settings = {}
      @prompt = TTY::Prompt.new
    end

    def build_game
      clarify_rules
      @settings[:game_mode] = game_mode
      @settings[:rounds] = rounds
      @settings[:human_player_role] = human_player_role if @settings[:game_mode] == 'single player'
      build_players
    end

    private

    def build_players
      case @settings[:game_mode]
      when 'single player'
        @human_player = Human.new(false)
        @computer_player = Computer.new(@settings[:human_player_role])
        start_single_player_game
      when 'multiplayer'
        @players = [Human.new(true, 'first'), Human.new(true, 'second')]
        start_multiplayer_game
      end
    end

    def first_player_role
      puts
      player_role = @prompt.select("#{@players[0].player_name}, choose your role", ['Code Maker', 'Code Breaker'])
      player_role.downcase!
      clear_screen
      player_role
    end

    def distribute_roles
      role = first_player_role
      @players[0], @players[1] = @players[1], @players[0] if role == 'code breaker'
    end

    def start_single_player_game
      game = MasterMind::SinglePlayerGame.new(@human_player,
                                              @computer_player,
                                              @settings[:rounds],
                                              @settings[:human_player_role])
      game.play
      clear_screen || start_single_player_game if game.play_again?
    end

    def start_multiplayer_game
      distribute_roles
      game = MasterMind::MultiplayerGame.new(*@players, @settings[:rounds])
      game.play
      clear_screen || start_multiplayer_game if game.play_again?
    end

    def clarify_rules
      show_guide
      @prompt.keypress('Press any key to continue')
      clear_screen
    end

    def game_mode
      puts
      mode = @prompt.select('Choose a game mode', ['Single Player', 'Multiplayer']).downcase
      clear_screen
      mode
    end

    def rounds
      puts
      rounds = @prompt.select('Choose how many rounds to play', [4, 6, 8, 10, 12], default: 3)
      clear_screen
      rounds
    end

    def human_player_role
      puts
      player_role = @prompt.select('Choose your role', ['Code Maker', 'Code Breaker']).downcase
      clear_screen
      player_role
    end
  end
end
