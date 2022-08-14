# frozen_string_literal: true

module MasterMind
  module Display
    # Text/instructions to display to the player(s) on desktop
    module DesktopDisplay
      def show_guide
        puts
        Board.new.draw('123456', 1, 1)
        puts
        puts TTY::Box.info(GUIDE)
        puts
      end
    end
  end
end
