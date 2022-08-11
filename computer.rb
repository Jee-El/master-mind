# frozen_string_literal: true

require 'tty-prompt'

require_relative './hints'
require_relative './display'

module MasterMind
  # The computer players
  class Computer
    attr_reader :secret_code, :player_name

    include Display

    def initialize(human_player_role)
      @prompt = TTY::Prompt.new
      @player_name = 'Computer'
      setup_for_breaking_secret_code if human_player_role == 'code maker'
    end

    def make_secret_code
      @secret_code = Array.new(4) { [*(1..6)].sample }.join
    end

    def break_secret_code(code_maker, rounds, board)
      make_a_dup_of_all_codes
      @made_guesses = 0
      rounds.times do
        @guess = make_guess
        @made_guesses += 1
        @hints = @hints_giver.give(@guess, code_maker.secret_code)
        sleep 1.25
        clear_screen
        board.draw(@guess, *@hints)
        return [player_name, true] if @hints == [4, 0]
      end
      [code_maker.player_name, false, code_maker.secret_code]
    end

    private

    def setup_for_breaking_secret_code
      @hints_giver = HintsGiver.new
      build_all_possible_codes
    end

    def build_all_possible_codes
      @all_codes = [*(1..6)].repeated_permutation(4).to_a.map(&:join).to_set
    end

    def make_a_dup_of_all_codes
      @all_possible_codes = @all_codes.dup
    end

    def make_guess
      @made_guesses.positive? ? remove_impossible_guesses.min : '1122'
    end

    def remove_impossible_guesses
      @all_possible_codes.keep_if { |code| @hints_giver.give(@guess, code) == @hints }
    end
  end
end
