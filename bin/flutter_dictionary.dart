import 'package:flutter_dictionary/flutter_dictionary.dart'
    as flutter_dictionary;

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class DictionaryEntry {
  final String term;
  final String meaning;

  DictionaryEntry({required this.term, required this.meaning});

  factory DictionaryEntry.create(Map<String, dynamic> jsonMap) {
    String term = jsonMap['word'];
    String meaning = jsonMap['meanings'][0]['definitions'][0]['definition'];
    return DictionaryEntry(term: term, meaning: meaning);
  }
}

Future<void> main() async {
  print("==== Simple Dictionary App ====");

  bool keepRunning = true;

  while (keepRunning) {
    stdout.write("\nType a word to define (or type 'exit' to quit): ");
    String? userWord = stdin.readLineSync();

    if (userWord == null || userWord.toLowerCase() == "exit") {
      print("Session closed.");
      keepRunning = false;
      continue;
    }

    String requestUrl =
        "https://api.dictionaryapi.dev/api/v2/entries/en/$userWord";

    try {
      var reply = await http.get(Uri.parse(requestUrl));

      if (reply.statusCode == 200) {
        var parsed = jsonDecode(reply.body) as List<dynamic>;
        var entry = DictionaryEntry.create(parsed[0]);

        print("\nWord Definition");
        print("---------------- -------------------------------");
        print("${entry.term.padRight(15)} ${entry.meaning}");
      } else {
        print(" No results found for: $userWord");
      }
    } catch (problem) {
      print("Error occurred: $problem");
    }
  }
}
