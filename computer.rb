# frozen_string_literal: true

require 'tty-prompt'
require 'tty-spinner'

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
      if human_player_role == 'code maker'
        spinner = TTY::Spinner.new('[:spinner] The computer is warming up...', format: :arrow_pulse)
        spinner.auto_spin
        setup_for_breaking_secret_code
        spinner.stop("\n\nThe computer is ready to take you on!")
      end
    end

    def make_secret_code
      @secret_code = Array.new(4) { [*(1..6)].sample }.join
    end

    def break_secret_code(code_maker, rounds, board)
      make_copies_of_hints_and_codes
      @made_guesses = 0
      rounds.times do
        @guess = make_guess
        @made_guesses += 1
        @hints = @hints_giver.give(@guess, code_maker.secret_code)
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
      build_all_possible_hints
    end

    def build_all_possible_codes
      @all_codes = [*(1..6)].repeated_permutation(4).to_a.map(&:join)
    end

    def build_all_possible_hints
      @all_hints = Hash.new { |h, k| h[k] = {} }
      @all_codes.product(@all_codes).each do |guess, secret_code|
        @all_hints[guess][secret_code] = @hints_giver.give(guess, secret_code)
      end
      @all_codes.to_set
    end

    def make_copies_of_hints_and_codes
      @all_possible_codes = @all_codes.dup
      @all_possible_hints = @all_hints.dup
    end

    def make_guess
      if @made_guesses.positive?
        remove_impossible_guesses
        knuth_algorithm
      else
        '1122'
      end
    end

    def remove_impossible_guesses
      @all_possible_codes.keep_if { |code| @all_possible_hints.dig(@guess, code) == @hints }
    end

    def knuth_algorithm(best_score = Float::INFINITY, next_guess = nil)
      @all_possible_hints.each do |guess, hints_by_secret_codes|
        remove_impossible_secret_codes(guess, hints_by_secret_codes)

        score = highest_frequency(hints_by_secret_codes)

        if @all_possible_codes.include?(guess) && best_score > score
          best_score = score
          next_guess = guess
        end
      end
      next_guess
    end

    def remove_impossible_secret_codes(guess, hints_by_secret_codes)
      hints_by_secret_codes = hints_by_secret_codes.filter do |secret_code, _hint|
        @all_possible_codes.include?(secret_code)
      end
      @all_possible_hints[guess] = hints_by_secret_codes
    end

    def hints_frequency(hints_by_secret_codes)
      frequency_by_hints = hints_by_secret_codes.keys.group_by { |k| hints_by_secret_codes[k] }
      frequency_by_hints.values.map(&:length)
    end

    def highest_frequency(hints_by_secret_codes)
      hints_frequency(hints_by_secret_codes).max
    end
  end
end
