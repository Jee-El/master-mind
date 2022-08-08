# frozen_string_literal: true

module MasterMind
  # Give hints to the code breaker
  module Hints
    def hints(guess, secret_code)
      not_black_pegs_guess = []
      not_black_pegs_secret_code = []
      pegs = { black: 0, white: 0 }
      guess_secret_code_pairs = guess.chars.zip(secret_code.chars)
      black_pegs(pegs, guess_secret_code_pairs, not_black_pegs_guess, not_black_pegs_secret_code)
      white_pegs(pegs, not_black_pegs_guess, not_black_pegs_secret_code)
      pegs.values
    end

    def black_pegs(pegs, guess_secret_code_pairs, not_black_pegs_guess, not_black_pegs_secret_code)
      guess_secret_code_pairs.each do |pair|
        next pegs[:black] += 1 if pair[0] == pair[1]

        not_black_pegs_guess << pair[0]
        not_black_pegs_secret_code << pair[1]
      end
    end

    def white_pegs(pegs, not_black_pegs_guess, not_black_pegs_secret_code)
      not_black_pegs_guess.each do |not_black_peg_guess|
        if not_black_pegs_secret_code.include?(not_black_peg_guess)
          pegs[:white] += 1
          not_black_pegs_secret_code.delete(not_black_peg_guess)
        end
      end
    end
  end
end
