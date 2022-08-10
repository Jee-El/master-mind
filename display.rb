require 'tty-prompt'

module MasterMind
  module Display
    def show_guide
      puts
      Board.new.draw('123456', 1, 1)
      puts
      puts TTY::Box.frame("- Code maker makes a pattern of four colors, e.g: rrgg, 2211 or redredgreengreen,\n\n"\
                          "- The code breaker has to figure out this pattern,\n\n"\
                          "- Available numbers/colors : 1-6 | #{'Green'.green} #{'Red'.red} #{'Yellow'.yellow} "\
                          "#{'Blue'.blue} #{'Magenta'.magenta} #{'Cyan'.cyan}\n\n"\
                          "- The code maker gives hints, represented by black/white rectangle,\n\n"\
                          "- Each black one & each white one implies that one of the colors guessed is\n"\
                          "  in the pattern made by the code maker,\n\n"\
                          "- Each black one implies that that color is also in the right position\n"\
                          "  while white ones don't,\n\n"\
                          "- Order matters, so gryb != byrg,\n\n"\
                          "- Duplicates are allowed, so rrrr is allowed,\n\n"\
                          "- Blanks are *not* allowed, so rrr is *not* allowed.\n\n",
                          padding: [1, 1],
                          border: :ascii)
      puts
    end

    def announce_winner(winner, is_code_broken)
      bottom_text = " The code was #{is_code_broken ? '' : 'not '}broken! "
      puts
      puts TTY::Box.frame(winner,
                          padding: [1, 1],
                          align: :center,
                          border: :ascii,
                          title: { top_center: 'The Winner Is', bottom_center: bottom_text })
      puts
    end

    def clear_screen
      puts "\e[1;1H\e[2J"
    end
  end
end
