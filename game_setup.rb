# frozen_string_literal: true

require 'tty-prompt'
require 'tty-box'
require 'colorize'

require_relative './board'

module MasterMind
  # Setup game mode, human player role, rounds to play
  class GameSetup
    attr_reader :settings

    def initialize
      @settings = {}
      @prompt = TTY::Prompt.new
    end

    def start
      clarify_rules
      @settings[:game_mode] = game_mode
      @settings[:rounds] = rounds
      @settings[:human_player_role] = human_player_role if @settings[:game_mode] == 'single player'
    end

    private

    def clarify_rules
      puts
      puts TTY::Box.frame("#{Board.new.draw('123456', 1, 1)}"\
                          "- Code maker makes a pattern of four colors, e.g: rrgg, 2211 or redredgreengreen,\n\n"\
                          "- The code breaker has to figure out this pattern,\n\n"\
                          "- Available numbers/colors : 1-6 | #{'Green'.green} #{'Red'.red} #{'Yellow'.yellow} #{'Blue'.blue} #{'Magenta'.magenta} #{'Cyan'.cyan}\n\n"\
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
      @prompt.keypress('Press any key to continue')
      clear_screen
    end

    def game_mode
      puts
      mode = @prompt.select('Choose a game mode', ['Single Player', 'Multiplayer']).downcase
      clear_screen
      mode
    end

    def rounds
      puts
      rounds = @prompt.select('Choose how many rounds to play', [4, 6, 8, 10, 12], default: 3)
      clear_screen
      rounds
    end

    def human_player_role
      puts
      player_role = @prompt.select('Choose your role', ['Code Maker', 'Code Breaker']).downcase
      clear_screen
      player_role
    end

    def clear_screen
      puts "\e[1;1H\e[2J"
    end
  end
end
