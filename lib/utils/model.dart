import 'dart:math';

// database table and column names
final String infos = 'words';
final String columnId = '_id';
final String columnIdade = 'idade';
final String columnAltura = 'altura';
final String columnPeso = 'peso';
final String columnSexo = 'sexo';

// data model class
class Info {
  final int? id;
  final String? idade;
  final String? altura;
  final String? peso;
  final String? sexo;

  Info(this.id, this.idade, this.altura, this.peso, this.sexo);

  // convenience constructor to create a Word object
  factory Info.fromMap(Map<String, dynamic> map) => Info(map[columnId],
      map[columnIdade], map[columnAltura], map[columnPeso], map[columnSexo]);

  // factory Info.random() => Info(Random().nextInt(99).hashCode, 'Random Data',
  //    Random().nextInt(99).hashCode);

  // convenience method to create a Map from this Word object
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnIdade: idade,
      columnAltura: altura,
      columnPeso: peso,
      columnSexo: sexo
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }
}
