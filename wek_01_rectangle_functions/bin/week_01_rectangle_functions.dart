import 'dart:io';

import 'package:week_01_rectangle_functions/week_01_rectangle_functions.dart'
    as rectangle;

void main(List<String> arguments) {
  late int width;
  late int length;
  late int height;
  late String option;

  // program title
  print('==== Rectangle Surface Area and Volume ====');

  do {
    print('\n---Menu of Options ---');
    print('[a]rea of rectangle');
    print('[v]olume of rectangle');
    print('e[x]it');
    print('');

    stdout.write('Enter option: ');
    option = stdin.readLineSync() as String;

    switch (option) {
      case 'a':
        width = promptInt('Please enter the width: ');
        length = promptInt('Please enter the length: ');
        height = promptInt('Please enter the height: ');
        stdout.write('The surface area of a rectangle with width: ');
        stdout.write('$width, length: $length, ');
        stdout.write('and height: $height is ');
        print('${rectangle.surfaceArea(width, length, height)}');
        break;
      case 'v':
        width = promptInt('Please enter the width: ');
        length = promptInt('Please enter the length: ');
        height = promptInt('Please enter the height: ');
        stdout.write('The volume of a rectangle with width: ');
        stdout.write('$width, length: $length, ');
        stdout.write('and height: $height is ');
        print('${rectangle.volume(width, length, height)}');
        break;
      case 'x':
        print('Goodbye');
        break;
      default:
        print('Sorry, "$option" is not a valid option');
        break;
    }
  } while (option != 'x');
}

/// Returns an [int] entered by the user
int promptInt(prompt) {
  while (true) {
    stdout.write(prompt);
    try {
      return int.parse(stdin.readLineSync()!);
    } catch (e) {
      print('Something went wrong: $e');
    }
  }
}
