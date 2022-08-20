# frozen_string_literal: true

require 'tty-box'

module MasterMind
  module Display
    # Text/instructions to display to the player(s) on mobile
    module PhoneDisplay
      def show_guide
        puts
        PhoneBoard.new.draw('123456', 1, 1)
        puts
        puts GUIDE
        puts
      end

      def ask_for_return_button_press
        puts
        print 'Press enter (or return) to continue'
      end

      def ask_for_first_player_role
        puts
        puts TTY::Box.frame("1 -> Code Maker\n\n2 -> Code Breaker",
                            padding: [1, 1],
                            title: { top_center: " #{@players[0].player_name}, choose your role : " })
        puts
      end

      def ask_for_game_mode
        puts
        puts TTY::Box.frame("1 -> Single Player\n\n2 -> Multiplayer",
                            padding: [1, 1],
                            title: { top_center: ' Choose a game mode : ' })
        puts
      end

      def ask_for_game_rounds
        puts
        puts 'How many rounds to play?'
        puts
        puts 'Available amounts : 4, 6, 8, 10, 12'
        puts
      end

      def ask_for_human_player_role
        puts
        puts TTY::Box.frame("1 -> Code Maker\n\n2 -> Code Breaker",
                            padding: [1, 1],
                            title: { top_center: ' Choose your role : ' })
        puts
      end
    end
  end
end
