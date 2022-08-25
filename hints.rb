# frozen_string_literal: true

module MasterMind
  # Give hints to the code breaker
  class Hints
    def self.give(guess, secret_code)
      pegs = { black: 0, white: 0 }
      black_pegs(pegs, guess, secret_code)
      white_pegs(pegs, guess, secret_code)
      pegs.values
    end

    private_class_method def self.black_pegs(pegs, guess, secret_code)
      4.times { |i| pegs[:black] += 1 if guess[i] == secret_code[i] }
    end

    private_class_method def self.white_pegs(pegs, guess, secret_code)
      used_nums = (guess.chars + secret_code.chars).uniq
      used_nums.each { |used_num| pegs[:white] += [guess.count(used_num), secret_code.count(used_num)].min }
      pegs[:white] -= pegs[:black]
    end
  end
end
