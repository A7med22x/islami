class Radio {
  final int id;
  final String name;
  final String url;
  final String? recentDate;

  const Radio({
    required this.id,
    required this.name,
    required this.url,
    this.recentDate,
  });

  factory Radio.fromJson(Map<String, dynamic> json) => Radio(
    id: json['id'] as int,
    name: json['name'] as String,
    url: json['url'] as String,
    recentDate: json['recent_date'] as String?,
  );
}
