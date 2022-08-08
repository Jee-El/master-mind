# frozen_string_literal: true

require_relative './messages'
require_relative './player'

module MasterMind
  # The human player
  class Human
    attr_reader :secret_code

    def make_secret_code(multiplayer: false)
      # @secret_code = ask_for_secret_code(multiplayer)
      p @secret_code = Array.new(4) { [*(1..6)].sample }.join
    end

    def break_secret_code(code_maker, rounds, board)
      rounds.times do
        puts 'enter 4 nums'
        guess = make_guess
        board.draw_guess(guess)
        hints = hints(guess, code_maker.secret_code)
        board.draw_hints(*hints)
        return announce_winner('Human', true) if hints == [4, 0]
      end
      board.draw_guess(code_maker.secret_code)
      announce_winner('computer', false)
    end

    private

    include Messages
    include Hints

    def make_guess
      guess = gets.chomp
      until guess.length == 4 && guess.split('').map(&:to_i).join == guess
        puts 'enter appropriate secret_code'
        guess = gets.chomp
      end
      guess
    end
  end
end
