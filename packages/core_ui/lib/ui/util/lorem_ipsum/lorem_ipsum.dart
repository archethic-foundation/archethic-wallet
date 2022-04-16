/// SPDX-License-Identifier: AGPL-3.0-or-later

// Dart imports:
import 'dart:math';

// Package imports:
import 'package:core_ui/ui/util/lorem_ipsum/words.dart';

Random _random = Random();

String loremIpsum(
    {int paragraphs = 1, int words = 100, bool initWithLorem = false}) {
  if (paragraphs == null || paragraphs < 0) {
    throw ArgumentError.value(paragraphs, "paragraphs");
  }
  if (words == null || words < 0) {
    throw ArgumentError.value(words, "words");
  }

  if (paragraphs == 0 || words == 0) {
    return "";
  }

  if (paragraphs > words) {
    paragraphs = words;
  }

  String _lorem = _makeParagraphs(paragraphs, words);
  if (words > 3 && initWithLorem) {
    _lorem = _lorem.replaceAll(_lorem.split(" ")[0], "Lorem");
    _lorem = _lorem.replaceAll(_lorem.split(" ")[1], "ipsum,");
    return _lorem;
  }
  return _lorem;
}

String _makeParagraphs(int paragraphs, int words) {
  int wordLength = words ~/ paragraphs;
  List<String> result = [];

  for (int i = 0; i < paragraphs - 1; i++) {
    result.add(_makeParagraph(wordLength));
  }
  result.add(_makeParagraph(wordLength + (words % paragraphs)));
  return result.join("\n\n");
}

String _makeParagraph(int words) {
  int remain = words;
  List<String> result = [];
  if (words == 1) {
    return _makeSentence(1);
  }

  while (remain > 0) {
    int length = _randomInt(2, min(10, remain));
    if (remain - length < 2) {
      length = remain;
    }

    result.add(_makeSentence(length));
    remain -= length;
  }
  return result.join(" ");
}

String _makeWord() {
  int n = _random.nextInt(2);
  String chosen;
  do {
    chosen = wordList[_random.nextInt(wordList.length)];
  } while (n > 0 && chosen.length > 5);
  return chosen;
}

String _makeSentence(int words) {
  List<String> result = [];
  int commas = 0;
  bool lastWasComma = false;
  for (int i = 0; i < words; i++) {
    String nextWord = _makeWord();
    if (lastWasComma) {
      lastWasComma = false;
    } else if (i != (words - 1) && commas < 2) {
      int n = _randomInt(1, 7);
      if (n == 1) {
        nextWord += ",";
        commas++;
        lastWasComma = true;
      }
    }
    result.add(nextWord);
  }
  result[0] = result[0].substring(0, 1).toUpperCase() + result[0].substring(1);
  return result.join(" ") + ".";
}

_randomInt(int min, int max) {
  Random rnd = Random();
  return rnd.nextInt((max - min) + 1) + min;
}
