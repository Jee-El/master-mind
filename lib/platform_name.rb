# frozen_string_literal: true

require 'tty-box'

module MasterMind
  # Gets the name of the device
  # to choose which game_setup to instantiate
  module PlatformName
    def self.get
      platform_names_by_numbers = { '1' => 'Phone', '2' => 'Computer' }
      puts
      puts TTY::Box.frame("1 -> Phone\n\n2 -> Computer",
                          padding: [1, 1],
                          title: { top_center: ' What device are you using? ' })
      loop do
        name = gets.chomp
        break platform_names_by_numbers[name] if name.strip.match?(/^(1|2)$/)

        print 'Enter either the number 1 or 2 : '
      end
    end
  end
end
