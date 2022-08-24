# frozen_string_literal: true

module MasterMind
  # Give hints to the code breaker
  class Hints
    def self.give(guess, secret_code)
      not_black_pegs_guess = []
      not_black_pegs_secret_code = []
      pegs = { black: 0, white: 0 }
      guess_secret_code_pairs = guess.chars.zip(secret_code.chars)
      black_pegs(pegs, guess_secret_code_pairs, not_black_pegs_guess, not_black_pegs_secret_code)
      white_pegs(pegs, not_black_pegs_guess, not_black_pegs_secret_code)
      pegs.values
    end

    private

    def self.black_pegs(pegs, guess_secret_code_pairs, not_black_pegs_guess, not_black_pegs_secret_code)
      guess_secret_code_pairs.each do |pair|
        next pegs[:black] += 1 if pair[0] == pair[1]

        not_black_pegs_guess << pair[0]
        not_black_pegs_secret_code << pair[1]
      end
    end

    def self.white_pegs(pegs, not_black_pegs_guess, not_black_pegs_secret_code)
      pegs[:white] += (not_black_pegs_guess + not_black_pegs_secret_code).uniq.reduce(0) do |total, num|
        total += [not_black_pegs_guess.count(num), not_black_pegs_secret_code.count(num)].min
      end
    end
  end
end