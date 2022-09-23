require 'colorize'

module MasterMind
  # Handles drawing the code pegs & key pegs
  class Board
    attr_accessor :board

    COLORS_BY_NUMBERS = {
      '1' => :green,
      '2' => :red,
      '3' => :yellow,
      '4' => :blue,
      '5' => :magenta,
      '6' => :cyan,
      '7' => :black,
      '8' => :white
    }.freeze

    def initialize
      @board = []
    end

    private

    def draw(has_to_show_secret_code)
      puts has_to_show_secret_code ? @board.last : @board
      @board << ''
    end

    def draw_guess(guess)
      code_pegs = ''
      guess.chars.each do |num|
        if COLORS_BY_NUMBERS.key?(num)
          code_pegs << "  #{num}  ".colorize(background: COLORS_BY_NUMBERS[num])
          code_pegs << ' '
        end
      end
      code_pegs
    end

    def draw_hints(black_pegs, white_pegs)
      key_pegs = ''
      draw_black_pegs(key_pegs, black_pegs)
      draw_white_pegs(key_pegs, white_pegs)
      key_pegs
    end

    def draw_black_pegs(key_pegs, black_pegs)
      black_pegs.times do
        key_pegs << '     '.colorize(background: COLORS_BY_NUMBERS['7'])
        key_pegs << ' '
      end
    end

    def draw_white_pegs(key_pegs, white_pegs)
      white_pegs.times do
        key_pegs << '     '.colorize(background: COLORS_BY_NUMBERS['8'])
        key_pegs << ' '
      end
    end
  end
end
