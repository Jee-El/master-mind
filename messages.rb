# frozen_string_literal: true

require 'tty-box'
require 'tty-prompt'

module MasterMind
  # Prompts to display to the player(s)
  module Messages
    PROMPT = TTY::Prompt.new

    def ask_for_game_mode
      PROMPT.select('Choose a game mode', ['Single Player', 'Multiplayer'])
    end

    def ask_for_human_player_role
      PROMPT.select('Choose your role', ['Code Maker', 'Code Breaker'])
    end

    def ask_for_rounds_amount
      PROMPT.select('Choose how many rounds to play', [2, 4, 6, 8, 10], default: 5)
    end

    def ask_for_secret_code(multiplayer)
      question = 'Enter your secret code'
      if multiplayer
        PROMPT.mask(question)
      else
        PROMPT.ask(question)
      end
    end

    def announce_winner(winner, is_code_broken)
      bottom_text = " The code was #{is_code_broken ? '' : 'not '}broken! "
      puts TTY::Box.frame(winner,
                          padding: [1, 1],
                          align: :center,
                          border: :ascii,
                          title: { top_center: 'The Winner Is', bottom_center: bottom_text })
    end
  end
end
