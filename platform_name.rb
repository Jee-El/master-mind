# frozen_string_literal: true

require 'tty-box'

def platform_name
  platform_names_by_numbers = { '1' => 'Phone', '2' => 'Computer' }
  puts
  puts TTY::Box.frame("1 -> Phone\n\n2 -> Computer",
                      padding: [1, 1],
                      title: { top_center: ' Are you on a phone or a computer? ' })
  loop do
    name = gets.chomp
    break platform_names_by_numbers[name] if name.strip.match?(/^(1|2)$/)

    print 'Enter either the number 1 or 2 : '
  end
end
