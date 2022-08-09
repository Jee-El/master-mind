# frozen_string_literal: true

require_relative './game_setup'
require_relative './single_player_game'
require_relative './multiplayer_game'

def start_game
  game_setup = MasterMind::GameSetup.new
  game_setup.start
  game_settings = game_setup.settings.values
  case game_settings[0]
  when 'single player'
    game = MasterMind::SinglePlayerGame.new(game_settings[1], game_settings[2])
  when 'multiplayer'
    game = MasterMind::MultiplayerGame.new(game_settings[1])
  end
  game.play
end
start_game
