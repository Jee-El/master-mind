module MasterMind
  # Turns user input into numbers
  class Translator
    NUMBERS_BY_COLORS_INITIALS = {
      'g' => '1',
      'r' => '2',
      'y' => '3',
      'b' => '4',
      'm' => '5',
      'c' => '6'
    }.freeze

    NUMBERS_BY_COLORS_NAMES = {
      'green' => '1',
      'red' => '2',
      'yellow' => '3',
      'blue' => '4',
      'magenta' => '5',
      'cyan' => '6'
    }.freeze

    def translate(guess)
      return guess if guess.match?(/^(\d{4})$/)

      return colors_initials_to_numbers(guess) if guess.match?(/^([grybmc]{4})$/)

      return colors_names_to_numbers(guess) if guess.match?(/^((green|red|yellow|blue|magenta|cyan){4})$/)
    end

    private

    def colors_initials_to_numbers(guess)
      guess.chars.each do |char|
        guess.gsub!(char, NUMBERS_BY_COLORS_INITIALS[char])
      end
      guess
    end

    def colors_names_to_numbers(guess)
      guess.chars.each do |char|
        guess.gsub!(char, NUMBERS_BY_COLORS_NAMES[char])
      end
      guess
    end
  end
end