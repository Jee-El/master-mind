require_relative './mobile_display'
require_relative './game_setup'

module MasterMind
  # Setup specific to mobile
  # tty-prompt doesn't work well on mobile
  class MobileGameSetup < GameSetup
    include MobileDisplay

    private

    def clarify_rules
      show_guide
      ask_for_return_button_press
      input = gets.chomp
      puts
      until input.empty?
        ask_for_return_button_press
        input = gets.chomp
        puts
      end
      clear_screen
    end

    def first_player_role
      player_roles_by_numbers = { '1' => 'Code Maker', '2' => 'Code Breaker' }
      ask_for_first_player_role
      player_role = validate_selection(gets.chomp, /^(1|2)$/, 'Enter either 1 or 2 : ')
      super(player_roles_by_numbers[player_role])
    end

    def game_mode
      game_modes_by_numbers = { '1' => 'Single Player', '2' => 'Multiplayer' }
      ask_for_game_mode
      mode = validate_selection(gets.chomp, /^(1|2)$/, 'Enter either the number 1 or 2 : ')
      super(game_modes_by_numbers[mode])
    end

    def game_rounds
      ask_for_game_rounds
      rounds = validate_selection(gets.chomp,
                                  /^(4|6|8|10|12)$/,
                                  'Enter either the number 4, 6, 8, 10, or 12 : ')
      super(rounds.to_i)
    end

    def human_player_role
      player_roles_by_numbers = { '1' => 'Code Maker', '2' => 'Code Breaker' }
      ask_for_human_player_role
      player_role = validate_selection(gets.chomp,
                                       /^(1|2)$/,
                                       'Enter either the number 1 or 2 : ')
      super(player_roles_by_numbers[player_role])
    end

    def validate_selection(input, regex, error_message)
      until input.strip.match?(regex)
        puts
        print error_message
        input = gets.chomp
      end
      input
    end
  end
end
