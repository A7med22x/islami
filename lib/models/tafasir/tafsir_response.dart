import 'package:islami/models/tafasir/tafsir.dart';

class TafsirResponse {
  final List<Tafsir> tafasir;

  const TafsirResponse({required this.tafasir});

  factory TafsirResponse.fromJson(Map<String, dynamic> json) => TafsirResponse(
    tafasir: (json['tafasir']['soar'] as List)
        .map((e) => Tafsir.fromJson(e))
        .toList(),
  );
}
