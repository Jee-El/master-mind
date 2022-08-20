# frozen_string_literal: true

module MasterMind
  module Display
    # Text/instructions to display to the player(s) on desktop
    module ComputerDisplay
      def show_guide
        puts
        ComputerBoard.new.draw('123456', 1, 1)
        puts
        puts TTY::Box.info(GUIDE)
        puts
      end
    end
  end
end
