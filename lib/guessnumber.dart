// ignore_for_file: avoid_print

import 'dart:io';
import 'game.dart';

void main() {
  while (true) {
    playGame();
    String? input;
    do {
      stdout.write('Play again? (Y/N): ');
      input = stdin.readLineSync();
    } while (input!.toLowerCase() != 'y' && input.toLowerCase() != 'n');

    if (input.toLowerCase() == 'n') break;
  }

  print('\n\nYou\'ve played ${Game.guessCountList.length} games');
  for (var i = 0; i < Game.guessCountList.length; i++) {
    print('🚀 Game #${i + 1}: ${Game.guessCountList[i]} guesses');
  }
}

void playGame() {
  int? maxRandom;
  do {
    stdout.write('\nEnter a maximum number to random: ');
    var input = stdin.readLineSync();
    maxRandom = int.tryParse(input!);
  } while (maxRandom == null);

  var game = Game(maxRandom: maxRandom);
  var isCorrect = false;

  print('');
  print('╔════════════════════════════════════════');
  print('║            GUESS THE NUMBER            ');
  print('╟────────────────────────────────────────');

  stdout.write('║ Guess the number between 1 and $maxRandom: ');
  var input = stdin.readLineSync();
  var guess = int.tryParse(input!);
  if (guess == null) {}
  var result = game.doGuess(guess!);
  if (result == 1) {
    print('║ ➜ $guess is TOO HIGH! ▲');
    print('╟────────────────────────────────────────');
  } else if (result == -1) {
    print('║ ➜ $guess is TOO LOW! ▼');
    print('╟────────────────────────────────────────');
  } else if (result == 0) {
    print('║ ➜ $guess is CORRECT ❤, total guesses: ${game.guessCount}');
    print('╟────────────────────────────────────────');
    isCorrect = true;
    game.addCountList();
  }
  print('║                 THE END                ');
  print('╚════════════════════════════════════════');
}
