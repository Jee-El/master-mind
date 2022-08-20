# frozen_string_literal: true

require_relative './platform_name'
require_relative './phone_game_setup'
require_relative './computer_game_setup'

case platform_name
when 'Phone' then MasterMind::PhoneGameSetup.new.build_game
when 'Computer' then MasterMind::ComputerGameSetup.new.build_game
end
