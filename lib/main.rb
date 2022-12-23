# frozen_string_literal: true

require_relative 'platform_name'
require_relative 'game_setup/phone_game_setup/phone_game_setup'
require_relative 'game_setup/computer_game_setup/computer_game_setup'

case MasterMind::PlatformName.get
when 'Phone' then MasterMind::PhoneGameSetup.new.build_game
when 'Computer' then MasterMind::ComputerGameSetup.new.build_game
end
