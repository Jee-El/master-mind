require 'colorize'

module MasterMind
  # Handles drawing the code pegs & key pegs
  class Board
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

    def draw(guess, black_pegs = 0, white_pegs = 0)
      puts
      puts "#{draw_guess(guess)} | #{draw_hints(black_pegs, white_pegs)}"
    end

    private

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
