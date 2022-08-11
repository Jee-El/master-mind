# frozen_string_literal: true

require 'tty-prompt'
require_relative './hints'
require_relative './translator'
require_relative './display'

module MasterMind
  # The human player
  class Human
    attr_reader :secret_code, :player_name

    include Display

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
                       @prompt.ask('The code maker must enter the secret code :') do |q|
                         q.modify :down
                         q.modify
                         q.validate(REGEX_FOR_VALID_PATTERN)
                         q.messages[:valid?] = INVALID_PATTERN_MESSAGE
                       end.gsub(' ', '')
                     else
                       ask_for_pattern('Enter your secret code :')
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
        clear_screen
        board.draw(guess, *hints)
        return [player_name, true] if hints == [4, 0]
      end
      [code_maker.player_name, false, code_maker.secret_code]
    end

    private

    def guess
      ask_for_pattern('Enter a pattern of 4 numbers or colors :')
    end

    def ask_for_pattern(phrase)
      @prompt.ask(phrase) do |q|
        q.modify :down
        q.modify
        q.validate(REGEX_FOR_VALID_PATTERN)
        q.messages[:valid?] = INVALID_PATTERN_MESSAGE
      end.gsub(' ', '')
    end
  end
end
