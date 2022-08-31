# Master Mind

# Play it here

- Login not required :

  [Replit](https://replit.com/@Jee-El/Master-Mind?v=1)

- Login required :

  [![Run on Repl.it](https://replit.com/badge/github/Jee-El/master-mind)](https://replit.com/new/github/Jee-El/master-mind)

# Features

## Modes

There are two modes to play :

- Single Player :

  You play against the computer, which follows knuth's algorithm to guess.

- Multiplayer :

  You play against someone else locally. The secret code is hidden so they can't really see the code, unless they memorize the combination of keys you pressed, which can be either a bunch of numbers (e.g: 1122), letters (e.g: GGRR), or words (e.g: Green Green Red Red).

In both modes, you can play either as :

- The Code Maker :

  You make the secret code (the hints are given by the computer),

- The Code Breaker :

  You have to figure out the secret code.

The other role is played either by the computer, in single player mode, or by your friend, in multiplayer mode.

## Several Ways To Guess

The game is pretty forgiving & not strict when it comes to entering a guess.

Here are the 3 valid formats for guessing :

- Numbers :

  Any 4-digits combination of numbers from 1 to 6, each number references a color. See the guide shown at the start of the game for reference.

  Examples : 1234, 1 2 3 4, 1 23 4, 12 34.

- Colors' First Letter :

  Any 4-letters combination of the first letter of a valid color. The guide shown at the start of the game shows valid colors.

  Examples : RRGG, rrgg, RrGg, R r GG, r Rg G.

- Colors' Full Names :

  Any 4 words combination, each word representing the name of a valid color. The guide shown at the start of the game shows valid colors.

  Examples : Red red Green green, redredgreengreen, red redgreen green, redREDgreenGreen.

As shown in the examples above, empty spaces in-between numbers/letters/words are ignored, and so is the case of letters (lowercase/uppercase).

## Amounts of rounds to play

There are 5 options to choose from, usually you'd want to play 10/12 rounds in multiplayer mode.

Against the computer, it's going to win most of the time in 6 rounds or less, so choosing less rounds than that to have a fair winning chance is a good idea.