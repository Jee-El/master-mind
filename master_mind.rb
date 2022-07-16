module MasterMind
  class Game
    def initialize
      @game_over = false
      @human = HumanPlayer.new
      @bot = ComputerPlayer.new
      role == 1 ? @human.make_code && @bot.break_code : @bot.make_code && @human.break_code
      end_game
    end

    def role
      puts 'you wanna be code breaker or code maker?'
      puts "1 : code maker,\n2 : code breaker"
      role = gets.chomp.to_i
      role = gets.chomp.to_i until [1, 2].include?(role)
    end

    def end_game
      puts 'Congrats, You broke the code'
    end
  end

  class Player
    def hints_to(player)
      correct_guesses = 0
      close_guesses = 0
      player.guess.each_with_index do |num, i|
        next correct_guesses += 1 if num == player.code[i]

        close_guesses += 1 if player.code.include?(num)
      end
      [correct_guesses, close_guesses]
    end
  end

  class HumanPlayer < Player
    attr_reader :code, :guess

    def make_code
      @code = gets.chomp.to_i
      @code = gets.chomp.to_i until @code.length == 4 && @code.is_a?(Integer)
    end

    def break_code
      loop do
        puts 'enter 4 nums'
        break if guess == @bot.code

        hints = hints_to(@human)
        puts "#{hints[0]} correct num(s) and place(s)"
        puts "#{hints[1]} correct num but wrong place"
      end
    end

    def guess
      guess = gets.chomp
      guess = gets.chomp until guess.length == 4 && guess.each_char.is_a?(Integer)
      @guess = guess.split('').map(&:to_i)
    end
  end

  class ComputerPlayer < Player
    attr_reader :code, :guess

    def make_code
      @code = [*(1..6)].sample(4)
    end

    def break_code
      loop do
        break if guess == @bot.code

        @hints = hints_to(@bot)
      end
    end

    def guess
      @guess = [*(1..6)].sample(4) unless @hints
      end_game if @hints[0] == 4
    end
  end
end
MasterMind::Game.new
