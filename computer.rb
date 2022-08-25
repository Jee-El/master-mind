# frozen_string_literal: true

require 'tty-spinner'
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
      make_dups_of_hints_and_codes
      @made_guesses = 0
      rounds.times do
        if @made_guesses == 1
          start_loading_screen
          @guess = make_guess
          end_loading_screen
        else
          @guess = make_guess
          sleep 1.2
        end
        @made_guesses += 1
        @hints = Hints.give(@guess, code_maker.secret_code)
        clear_screen
        board.draw(@guess, *@hints)
        return [player_name, true] if @hints == [4, 0]
      end
      [code_maker.player_name, false, code_maker.secret_code]
    end

    private

    def start_loading_screen
      puts
      @spinner.auto_spin
    end

    def end_loading_screen
      @spinner.stop
    end

    def setup_for_breaking_secret_code
      @spinner = TTY::Spinner.new('[:spinner] This will take a while ...')
      start_loading_screen
      build_all_possible_codes
      build_all_possible_hints
      end_loading_screen
    end

    def build_all_possible_codes
      @all_codes = [*(1..6)].repeated_permutation(4).to_a.map(&:join)
    end

    def build_all_possible_hints
      @all_hints = Hash.new { |h, k| h[k] = {} }
      @all_codes.product(@all_codes).each do |guess, secret_code|
        @all_hints[guess][secret_code] = Hints.give(guess, secret_code)
      end
      @all_codes.to_set
    end

    def make_dups_of_hints_and_codes
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
      @all_possible_codes.keep_if { |code| @all_hints[@guess][code] == @hints }
    end

    def knuth_algorithm
      guesses = @all_possible_hints.map do |guess, hints_by_secret_codes|
        remove_impossible_secret_codes(guess, hints_by_secret_codes)

        score = highest_frequency(hints_by_secret_codes)

        impossible_guess = @all_possible_codes.include?(guess) ? 0 : 1

        [score, impossible_guess, guess.to_i]
      end
      guesses.min.last.to_s
    end

    def remove_impossible_secret_codes(guess, hints_by_secret_codes)
      hints_by_secret_codes = hints_by_secret_codes.filter do |secret_code, _hint|
        @all_possible_codes.include?(secret_code)
      end
      @all_possible_hints[guess] = hints_by_secret_codes
    end

    def hints_frequency(hints_by_secret_codes)
      hints_by_secret_codes.keys.group_by { |k| hints_by_secret_codes[k] }
    end

    def highest_frequency(hints_by_secret_codes)
      hints_frequency(hints_by_secret_codes).values.max_by(&:length).length
    end
  end
end
