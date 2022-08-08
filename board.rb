require 'colorize'

module MasterMind
  class Board
    def initialize
      @colors_by_numbers = {
        '1' => :green,
        '2' => :red,
        '3' => :yellow,
        '4' => :blue,
        '5' => :magenta,
        '6' => :cyan,
        '7' => :black,
        '8' => :white
      }
    end

    def draw_guess(guess)
      code_pegs = ''
      guess.chars.each do |num|
        if @colors_by_numbers.key?(num)
          code_pegs << "  #{num}  ".colorize( :background => @colors_by_numbers[num])
          code_pegs << ' '
        end
      end
      puts code_pegs
    end

    def draw_hints(black_pegs, white_pegs)
      key_pegs = ''
      draw_black_pegs(key_pegs, black_pegs)
      draw_white_pegs(key_pegs, white_pegs)
      puts key_pegs
    end

    def draw_black_pegs(key_pegs, black_pegs)
      black_pegs.times do
        key_pegs << "     ".colorize( :background => @colors_by_numbers['7'])
        key_pegs << ' '
      end
    end

    def draw_white_pegs(key_pegs, white_pegs)
      white_pegs.times do
        key_pegs << "     ".colorize( :background => @colors_by_numbers['8'])
        key_pegs << ' '
      end
    end
  end
end