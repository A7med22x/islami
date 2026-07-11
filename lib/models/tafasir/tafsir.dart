class Tafsir{
  final int id;
  final int tafsirId;
  final String name;
  final String url;
  final int suraId;

  Tafsir({
    required this.id,
    required this.tafsirId,
    required this.name,
    required this.url,
    required this.suraId,
  });

  factory Tafsir.fromJson(Map<String, dynamic> json) {
    return Tafsir(
      id: json['id'],
      tafsirId: json['tafsir_id'],
      name: json['name'],
      url: json['url'],
      suraId: json['sura_id'],
    );
  }
}