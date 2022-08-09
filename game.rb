# frozen_string_literal: true

require_relative './board'

module MasterMind
  # A game of master mind
  class Game
    private

    attr_reader :board

    def initialize
      @board = Board.new
    end

    def game_over(winner)
      unless winner[1]
        puts
        puts 'The secret code was :'
        board.draw(winner.last)
      end
      announce_winner(*winner[0, 2])
    end

    def announce_winner(winner, is_code_broken)
      bottom_text = " The code was #{is_code_broken ? '' : 'not '}broken! "
      puts
      puts TTY::Box.frame(winner,
                          padding: [1, 1],
                          align: :center,
                          border: :ascii,
                          title: { top_center: 'The Winner Is', bottom_center: bottom_text })
      puts
    end
  end
end
