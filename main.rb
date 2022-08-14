# frozen_string_literal: true

require_relative './platform_name'
require_relative './mobile_game_setup'
require_relative './desktop_game_setup'

case platform_name
when 'Phone' then MasterMind::MobileGameSetup.new.build_game
when 'Computer' then MasterMind::DesktopGameSetup.new.build_game
end
