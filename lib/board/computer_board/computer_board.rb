require_relative '../board'

module MasterMind
  # Adjusts the board for big screens
  class ComputerBoard < Board
    def draw(guess, black_pegs, white_pegs, has_to_show_secret_code: false)
      puts
      board << "#{draw_guess(guess)} | #{draw_hints(black_pegs, white_pegs)}"
      super(has_to_show_secret_code)
    end
  end
end
