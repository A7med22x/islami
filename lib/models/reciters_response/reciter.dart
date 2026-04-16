import 'moshaf.dart';

class Reciter {
  int id;
  String name;
  String letter;
  DateTime date;
  List<Moshaf> moshaf;

  Reciter({required this.id, required this.name, required this.letter, required this.date, required this.moshaf});

  factory Reciter.fromJson(Map<String, dynamic> json) => Reciter(
    id: json['id'] as int,
    name: json['name'] as String,
    letter: json['letter'] as String,
    date: DateTime.parse(json['date'] as String),
    moshaf: (json['moshaf'] as List<dynamic>)
        .map((e) => Moshaf.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}
