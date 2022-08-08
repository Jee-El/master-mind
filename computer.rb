# frozen_string_literal: true

require_relative './messages'
require_relative './player'

module MasterMind
  # The computer player
  class Computer
    attr_reader :secret_code

    def make_secret_code
      p @secret_code = Array.new(4) { [*(1..6)].sample }.join
    end

    def break_secret_code(code_maker, rounds, board)
      setup_for_breaking_secret_code

      @made_guesses = 0
      rounds.times do
        @guess = make_guess
        @made_guesses += 1
        board.draw_guess(@guess)
        @hints = hints(@guess, code_maker.secret_code)
        board.draw_hints(@hints)
        return announce_winner('Computer', true) if @hints == [4, 0]
      end
      board.draw_guess(code_maker.secret_code)
      announce_winner('Human', false)
    end

    private

    include Messages
    include Hints

    def setup_for_breaking_secret_code
      @all_codes = [*(1..6)].repeated_permutation(4).to_a.map(&:join)
      @all_hints = Hash.new { |h, k| h[k] = {} }
      @all_codes.product(@all_codes).each do |guess, secret_code|
        @all_hints[guess][secret_code] = hints(guess, secret_code)
      end
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
      @all_codes.filter! { |code| @all_hints.dig(@guess, code) == @hints }
    end

    def knuth_algorithm(best_score = Float::INFINITY, next_guess = nil)
      @all_hints.each do |guess, hints_by_secret_codes|
        remove_impossible_secret_codes(guess, hints_by_secret_codes)

        score = highest_frequency(hints_by_secret_codes)

        if @all_codes.include?(guess) && best_score > score
          best_score = score
          next_guess = guess
        end
      end
      next_guess
    end

    def remove_impossible_secret_codes(guess, hints_by_secret_codes)
      hints_by_secret_codes = hints_by_secret_codes.filter do |secret_code, _hint|
        @all_codes.include?(secret_code)
      end
      @all_hints[guess] = hints_by_secret_codes
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
