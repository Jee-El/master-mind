# frozen_string_literal: true

require 'tty-prompt'
require_relative './hints'
require_relative './translator'

module MasterMind
  # The human player
  class Human
    attr_reader :secret_code, :player_name

    def initialize(is_multiplayer, first_or_second_player = nil)
      @translator = Translator.new
      @prompt = TTY::Prompt.new
      if is_multiplayer
        @player_name = @prompt.ask("Enter the #{first_or_second_player} player's name :",
                                   default: "Human #{%w[first second].index(first_or_second_player) + 1}")
      else
        @player_name = @prompt.ask('Enter your name :', default: 'Human')
      end
      puts
    end

    def make_secret_code(is_multiplayer)
      puts
      @secret_code = if is_multiplayer
                       @prompt.mask('The code maker must enter the secret code :')
                     else
                       @prompt.ask('Enter your secret code :')
                     end
      @secret_code = @translator.translate(@secret_code)
      puts
    end

    def break_secret_code(code_maker, rounds, board)
      hints_giver = HintsGiver.new
      rounds.times do
        puts
        guess = @translator.translate(self.guess)
        hints = hints_giver.give(guess, code_maker.secret_code)
        board.draw(guess, *hints)
        return [@player_name, true] if hints == [4, 0]
      end
      [code_maker.player_name, false, code_maker.secret_code]
    end

    private

    def guess
      @prompt.ask('Enter a pattern of 4 numbers or colors :', required: true) do |q|
        q.modify :down
        q.validate(/^((\d{4})|([grybmc]{4})|((green|red|yellow|blue|magenta|cyan){4}))$/)
        q.messages[:valid?] = "The pattern must be made either of :\n\n"\
                              "- 4 numbers, each number represents a color\n\n"\
                              "- 4 letters, each letter represents the first letter of the color name\n\n"\
                              "- 4 words, each word must be a color name\n\n"\
                              "Available numbers/colors : 1-6 | #{'Green'.green} #{'Red'.red} #{'Yellow'.yellow} "\
                              "#{'Blue'.blue} #{'Magenta'.magenta} #{'Cyan'.cyan}\n\n"
      end
    end
  end
end
