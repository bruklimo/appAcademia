import 'dart:math';

// database table and column names
final String tableWords = 'words';
final String columnId = '_id';
final String columnWord = 'word';
final String columnFrequency = 'frequency';

// data model class
class Word {
  final int? id;
  final String? word;
  final int? frequency;

  Word(this.id, this.word, this.frequency);

  // convenience constructor to create a Word object
  factory Word.fromMap(Map<String, dynamic> map) =>
      Word(map[columnId], map[columnWord], map[columnFrequency]);

  factory Word.random() => Word(Random().nextInt(99).hashCode, 'Random Data',
      Random().nextInt(99).hashCode);

  // convenience method to create a Map from this Word object
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{columnWord: word, columnFrequency: frequency};
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }
}
