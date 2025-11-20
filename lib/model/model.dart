import 'dart:math';

import 'package:flutter/material.dart';

List<Map<String, dynamic>> MyNotes = [
  {
    'title': 'Note one',
    'content':
        'This is the first note and it contains a lot of things, firstly nothing, secondly a poem  f a lot of damn things',
  },
  {
    'title': 'Ai list and a lot of things too',
    'content': 'Ai is coming up soon do you thing it will change the world?',
  },
  {
    'title': 'random rizz',
    'content': 'did you fall from the sky? cause i .....',
  },
  {
    'title': 'bible verse',
    'content': 'and he said to him, if one believes all things are possible',
  },
];

Color getRandomColor() {
  final Random random = Random();
  return Color.fromARGB(
    255,
    random.nextInt(256),
    random.nextInt(256),
    random.nextInt(256),
  );
}
